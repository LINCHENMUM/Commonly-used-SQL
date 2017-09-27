大家都在讨论关于数据库优化方面的东东，刚好参与开发了一个数据仓库方面的项目，以下的一点东西算是数据库优化方面的学习+实战的一些心得体会了，拿出来大家共享。欢迎批评指正阿！ 

SQL语句： 
是对数据库(数据)进行操作的惟一途径； 
消耗了70%~90%的数据库资源；独立于程序设计逻辑，相对于对程序源代码的优化，对SQL语句的优化在时间成本和风险上的代价都很低； 
可以有不同的写法；易学，难精通。 

SQL优化： 
固定的SQL书写习惯，相同的查询尽量保持相同，存储过程的效率较高。 
应该编写与其格式一致的语句，包括字母的大小写、标点符号、换行的位置等都要一致 

ORACLE优化器： 
在任何可能的时候都会对表达式进行评估，并且把特定的语法结构转换成等价的结构，这么做的原因是 
要么结果表达式能够比源表达式具有更快的速度 
要么源表达式只是结果表达式的一个等价语义结构 
不同的SQL结构有时具有同样的操作（例如：= ANY (subquery) and IN (subquery)），ORACLE会把他们映射到一个单一的语义结构。 

1 常量优化： 
常量的计算是在语句被优化时一次性完成，而不是在每次执行时。下面是检索月薪大于2000的的表达式： 
sal &gt; 24000/12 
sal &gt; 2000 
sal*12 &gt; 24000 
如果SQL语句包括第一种情况，优化器会简单地把它转变成第二种。 
优化器不会简化跨越比较符的表达式，例如第三条语句，鉴于此，应尽量写用常量跟字段比较检索的表达式，而不要将字段置于表达式当中。否则没有办法优化，比如如果sal上有索引，第一和第二就可以使用，第三就难以使用。 

2 操作符优化： 
优化器把使用LIKE操作符和一个没有通配符的表达式组成的检索表达式转换为一个“=”操作符表达式。 
例如：优化器会把表达式ename LIKE 'SMITH'转换为ename = 'SMITH' 
优化器只能转换涉及到可变长数据类型的表达式，前一个例子中，如果ENAME字段的类型是CHAR(10)， 那么优化器将不做任何转换。 
一般来讲LIKE比较难以优化。 

其中： 
~~ IN 操作符优化： 
    优化器把使用IN比较符的检索表达式替换为等价的使用“=”和“OR”操作符的检索表达式。 
    例如，优化器会把表达式ename IN ('SMITH','KING','JONES')替换为 
ename = 'SMITH' OR ename = 'KING' OR ename = 'JONES‘ 

~~ ANY和SOME 操作符优化: 
    优化器将跟随值列表的ANY和SOME检索条件用等价的同等操作符和“OR”组成的表达式替换。 
    例如，优化器将如下所示的第一条语句用第二条语句替换： 
    sal &gt; ANY (:first_sal, :second_sal) 
    sal &gt; :first_sal OR sal &gt; :second_sal 
    优化器将跟随子查询的ANY和SOME检索条件转换成由“EXISTS”和一个相应的子查询组成的检索表达式。 
    例如，优化器将如下所示的第一条语句用第二条语句替换： 
    x &gt; ANY (SELECT sal FROM emp WHERE job = 'ANALYST') 
    EXISTS (SELECT sal FROM emp WHERE job = 'ANALYST' AND x &gt; sal) 

~~ ALL操作符优化: 
    优化器将跟随值列表的ALL操作符用等价的“=”和“AND”组成的表达式替换。例如： 
    sal &gt; ALL (:first_sal, :second_sal)表达式会被替换为： 
    sal &gt; :first_sal AND sal &gt; :second_sal 
    对于跟随子查询的ALL表达式，优化器用ANY和另外一个合适的比较符组成的表达式替换。例如 
    x &gt; ALL (SELECT sal FROM emp WHERE deptno = 10) 替换为： 
    NOT (x &lt;= ANY (SELECT sal FROM emp WHERE deptno = 10)) 
    接下来优化器会把第二个表达式适用ANY表达式的转换规则转换为下面的表达式： 
    NOT EXISTS (SELECT sal FROM emp WHERE deptno = 10 AND x &lt;= sal) 

~~ BETWEEN 操作符优化: 
    优化器总是用“&gt;=”和“&lt;=”比较符来等价的代替BETWEEN操作符。 
    例如：优化器会把表达式sal BETWEEN 2000 AND 3000用sal &gt;= 2000 AND sal &lt;= 3000来代替。 

~~ NOT 操作符优化: 
    优化器总是试图简化检索条件以消除“NOT”逻辑操作符的影响，这将涉及到“NOT”操作符的消除以及代以相应的比较运算符。 
    例如，优化器将下面的第一条语句用第二条语句代替： 
    NOT deptno = (SELECT deptno FROM emp WHERE ename = 'TAYLOR') 
    deptno &lt;&gt; (SELECT deptno FROM emp WHERE ename = 'TAYLOR') 
    通常情况下一个含有NOT操作符的语句有很多不同的写法，优化器的转换原则是使“NOT”操作符后边的子句尽可能的简单，即使可能会使结果表达式包含了更多的“NOT”操作符。 
    例如，优化器将如下所示的第一条语句用第二条语句代替： 
    NOT (sal &lt; 1000 OR comm IS NULL) 
    NOT sal &lt; 1000 AND comm IS NOT NULL sal &gt;= 1000 AND comm IS NOT NULL 

如何编写高效的SQL: 
    当然要考虑sql常量的优化和操作符的优化啦，另外，还需要： 

1 合理的索引设计： 
例：表record有620000行，试看在不同的索引下，下面几个SQL的运行情况： 
语句A 
SELECT count(*) FROM record 
WHERE date &gt;'19991201' and date &lt; '19991214‘ and amount &gt;2000 

语句B 
SELECT count(*) FROM record 
WHERE date &gt;'19990901' and place IN ('BJ','SH') 

语句C 
SELECT date,sum(amount) FROM record 
group by date 
1 在date上建有一个非聚集索引 
A：(25秒) 
B：(27秒) 
C：(55秒) 
分析： 
date上有大量的重复值，在非聚集索引下，数据在物理上随机存放在数据页上，在范围查找时，必须执行一次表扫描才能找到这一范围内的全部行。 
2 在date上的一个聚集索引 
A：（14秒） 
B：（14秒） 
C：（28秒） 
分析： 
在聚集索引下，数据在物理上按顺序在数据页上，重复值也排列在一起，因而在范围查找时，可以先找到这个范围的起末点，且只在这个范围内扫描数据页，避免了大范围扫描，提高了查询速度。 
3 在place，date，amount上的组合索引 
A：（26秒） 
C：（27秒） 
B：（&lt; 1秒） 
分析： 
这是一个不很合理的组合索引，因为它的前导列是place，第一和第二条SQL没有引用place，因此也没有利用上索引；第三个SQL使用了place，且引用的所有列都包含在组合索引中，形成了索引覆盖，所以它的速度是非常快的。 
4 在date，place，amount上的组合索引 
A： (&lt; 1秒) 
B：（&lt; 1秒） 
C：（11秒） 
分析： 
这是一个合理的组合索引。它将date作为前导列，使每个SQL都可以利用索引，并且在第一和第三个SQL中形成了索引覆盖，因而性能达到了最优。 

总结1 
缺省情况下建立的索引是非聚集索引，但有时它并不是最佳的；合理的索引设计要建立在对各种查询的分析和预测上。一般来说： 
有大量重复值、且经常有范围查询（between, &gt;,&lt; ，&gt;=,&lt; =）和order by、group by发生的列，考虑建立聚集索引； 
经 常同时存取多列，且每列都含有重复值可考虑建立组合索引；在条件表达式中经常用到的不同值较多的列上建立检索，在不同值少的列上不要建立索引。比如在雇员 表的“性别”列上只有“男”与“女”两个不同值，因此就无必要建立索引。如果建立索引不但不会提高查询效率，反而会严重降低更新速度。 
组合索引要尽量使关键查询形成索引覆盖，其前导列一定是使用最频繁的列。 

2 避免使用不兼容的数据类型： 
例如float和INt、char和varchar、bINary和varbINary是不兼容的。数据类型的不兼容可能使优化器无法执行一些本来可以进行的优化操作。例如: 
SELECT name FROM employee WHERE salary ＞ 60000 
在这条语句中,如salary字段是money型的,则优化器很难对其进行优化,因为60000是个整型数。我们应当在编程时将整型转化成为钱币型,而不要等到运行时转化。 

3 IS NULL 与IS NOT NULL： 
不 能用null作索引，任何包含null值的列都将不会被包含在索引中。即使索引有多列这样的情况下，只要这些列中有一列含有null，该列就会从索引中排 除。也就是说如果某列存在空值，即使对该列建索引也不会提高性能。任何在WHERE子句中使用is null或is not null的语句优化器是不允 许使用索引的。 

4 IN和EXISTS： 
EXISTS要远比IN的效率高。里面关系到full table scan和range scan。几乎将所有的IN操作符子查询改写为使用EXISTS的子查询。 
例子： 
语句1 
SELECT dname, deptno FROM dept 
WHERE deptno NOT IN 
(SELECT deptno FROM emp); 
语句2 
SELECT dname, deptno FROM dept 
WHERE NOT EXISTS 
(SELECT deptno FROM emp 
WHERE dept.deptno = emp.deptno); 
明显的，2要比1的执行性能好很多 
因为1中对emp进行了full table scan,这是很浪费时间的操作。而且1中没有用到emp的INdex， 
因为没有WHERE子句。而2中的语句对emp进行的是range scan。 

5 IN、OR子句常会使用工作表，使索引失效： 
如果不产生大量重复值，可以考虑把子句拆开。拆开的子句中应该包含索引。 

6 避免或简化排序： 
应当简化或避免对大型表进行重复的排序。当能够利用索引自动以适当的次序产生输出时，优化器就避免了排序的步骤。以下是一些影响因素： 
索引中不包括一个或几个待排序的列； 
group by或order by子句中列的次序与索引的次序不一样； 
排序的列来自不同的表。 
为了避免不必要的排序，就要正确地增建索引，合理地合并数据库表（尽管有时可能影响表的规范化，但相对于效率的提高是值得的）。如果排序不可避免，那么应当试图简化它，如缩小排序的列的范围等。 

7 消除对大型表行数据的顺序存取： 
在 嵌套查询中，对表的顺序存取对查询效率可能产生致命的影响。比如采用顺序存取策略，一个嵌套3层的查询，如果每层都查询1000行，那么这个查询就要查询 10亿行数据。避免这种情况的主要方法就是对连接的列进行索引。例如，两个表：学生表（学号、姓名、年龄??）和选课表（学号、课程号、成绩）。如果两个 表要做连接，就要在“学号”这个连接字段上建立索引。 
还可以使用并集来避免顺序存取。尽管在所有的检查列上都有索引，但某些形式的WHERE子句强迫优化器使用顺序存取。下面的查询将强迫对orders表执行顺序操作： 
SELECT ＊ FROM orders WHERE (customer_num=104 AND order_num&gt;1001) OR order_num=1008 
虽然在customer_num和order_num上建有索引，但是在上面的语句中优化器还是使用顺序存取路径扫描整个表。因为这个语句要检索的是分离的行的集合，所以应该改为如下语句： 
SELECT ＊ FROM orders WHERE customer_num=104 AND order_num&gt;1001 
UNION 
SELECT ＊ FROM orders WHERE order_num=1008 
这样就能利用索引路径处理查询。 

8 避免相关子查询： 
一个列的标签同时在主查询和WHERE子句中的查询中出现，那么很可能当主查询中的列值改变之后，子查询必须重新查询一次。查询嵌套层次越多，效率越低，因此应当尽量避免子查询。如果子查询不可避免，那么要在子查询中过滤掉尽可能多的行。 

9 避免困难的正规表达式： 
MATCHES和LIKE关键字支持通配符匹配，技术上叫正规表达式。但这种匹配特别耗费时间。例如：SELECT ＊ FROM customer WHERE zipcode LIKE “98_ _ _” 
即使在zipcode字段上建立了索引，在这种情况下也还是采用顺序扫描的方式。如果把语句改为SELECT ＊ FROM customer WHERE zipcode &gt;“98000”，在执行查询时就会利用索引来查询，显然会大大提高速度。 
另外，还要避免非开始的子串。例如语句：SELECT ＊ FROM customer WHERE zipcode[2，3] &gt;“80”，在WHERE子句中采用了非开始子串，因而这个语句也不会使用索引。 

10 不充份的连接条件： 
例：表card有7896行，在card_no上有一个非聚集索引，表account有191122行，在account_no上有一个非聚集索引，试看在不同的表连接条件下，两个SQL的执行情况： 
SELECT sum(a.amount) FROM account a,card b WHERE a.card_no = b.card_no 
（20秒） 
将SQL改为： 
SELECT sum(a.amount) FROM account a,card b WHERE a.card_no = b.card_no and a.account_no=b.account_no 
（&lt; 1秒） 
分析： 
在第一个连接条件下，最佳查询方案是将account作外层表，card作内层表，利用card上的索引，其I/O次数可由以下公式估算为： 
外层表account上的22541页+（外层表account的191122行*内层表card上对应外层表第一行所要查找的3页）=595907次I/O 
在第二个连接条件下，最佳查询方案是将card作外层表，account作内层表，利用account上的索引，其I/O次数可由以下公式估算为： 
外层表card上的1944页+（外层表card的7896行*内层表account上对应外层表每一行所要查找的4页）= 33528次I/O 
可见，只有充份的连接条件，真正的最佳方案才会被执行。 
多表操作在被实际执行前，查询优化器会根据连接条件，列出几组可能的连接方案并从中找出系统开销最小的最佳方案。连接条件要充份考虑带有索引的表、行数多的表；内外表的选择可由公式：外层表中的匹配行数*内层表中每一次查找的次数确定，乘积最小为最佳方案。 
不可优化的WHERE子句 
例1 
下列SQL条件语句中的列都建有恰当的索引，但执行速度却非常慢： 
SELECT * FROM record WHERE substrINg(card_no,1,4)='5378' 
(13秒) 
SELECT * FROM record WHERE amount/30&lt; 1000 
（11秒） 
SELECT * FROM record WHERE convert(char(10),date,112)='19991201' 
（10秒） 
分析： 
WHERE子句中对列的任何操作结果都是在SQL运行时逐列计算得到的，因此它不得不进行表搜索，而没有使用该列上面的索引；如果这些结果在查询编译时就能得到，那么就可以被SQL优化器优化，使用索引，避免表搜索，因此将SQL重写成下面这样： 
SELECT * FROM record WHERE card_no like '5378%' 
（&lt; 1秒） 
SELECT * FROM record WHERE amount&lt; 1000*30 
（&lt; 1秒） 
SELECT * FROM record WHERE date= '1999/12/01' 
（&lt; 1秒） 

11 存储过程中，采用临时表优化查询： 
例 
1．从parven表中按vendor_num的次序读数据： 
SELECT part_num，vendor_num，price FROM parven ORDER BY vendor_num 
INTO temp pv_by_vn 
这个语句顺序读parven（50页），写一个临时表（50页），并排序。假定排序的开销为200页，总共是300页。 
2．把临时表和vendor表连接，把结果输出到一个临时表，并按part_num排序： 
SELECT pv_by_vn，＊ vendor.vendor_num FROM pv_by_vn，vendor 
WHERE pv_by_vn.vendor_num=vendor.vendor_num 
ORDER BY pv_by_vn.part_num 
INTO TMP pvvn_by_pn 
DROP TABLE pv_by_vn 
这 个查询读取pv_by_vn(50页)，它通过索引存取vendor表1.5万次，但由于按vendor_num次序排列，实际上只是通过索引顺序地读 vendor表（40＋2=42页），输出的表每页约95行，共160页。写并存取这些页引发5＊160=800次的读写，索引共读写892页。 
3．把输出和part连接得到最后的结果： 
SELECT pvvn_by_pn.＊，part.part_desc FROM pvvn_by_pn，part 
WHERE pvvn_by_pn.part_num=part.part_num 
DROP TABLE pvvn_by_pn 
这样，查询顺序地读pvvn_by_pn(160页)，通过索引读part表1.5万次，由于建有索引，所以实际上进行1772次磁盘读写，优化比例为30∶1。 

好了，搞定。 
其实sql的优化，各种数据库之间都是互通的。