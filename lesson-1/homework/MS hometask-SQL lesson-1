1---------Осон (Easy)
1.	----Қуйидаги атамаларни таърифланг: маълумот (data), маълумотлар базаси (database), реляцион маълумотлар базаси (relational database), ва жадвал (table).

data -Ҳақиқатда мавжуд бўлган воқеа,нарса ва ҳодисалар ҳақидаги рақам, матн, сана, тасвир ва шу каби кўринишидаги қийматларга айтилади
database -Бир нечта жадваллар, индекcлар, ҳужжатлар ва бошқа объектлардан ташкил топадиган маълумотлар базаси
relational database- Маълумотлар жадвалларда сақланади ва жадваллар ўртасидаги боғланишлар калитлар (PRIMARY/FOREIGN KEY) орқали “реляция” (алоқа) билан ифодаланадиган базa тури. 
Қўшма сўровлар (JOIN) орқали турли жадваллардан маъноли натижа олинади.
table-  сатрлар  ва устунлардан ташкил топган ўзида маълумотларни жамлаган тузилма. 



2-----SQL Server’нинг бешта асосий хусусиятини санаб беринг

---Хавфсизлик ва аутентификация
---Юқори ишончлилик ва мавжудлик (HA/DR)
---Ижро самарадорлиги ва масштабланиш
---BI ва аналитика экосистемаси

---Т-SQL ва дастурлаш имкониятлари

3---.	SQL Server’га уланишда мавжуд аутентификация усуллари қайсилар? (камida 2тасини келтиринг)

1)  Windows Authentication (Integrated Security)-Домэн ёки локал Windows аккаунти орқали кириш
2)  SQL Server Authentication (Mixed Mode) -Login ва Password SQL Server’нинг ўзида сақланадиган ҳисоб ёзуви билан кириш
3)  Azure Active Directory (Azure AD) Authentication- Azure муҳитларида (Azure SQL Database/Managed Instance, ҳамда SQL Server



----Ўрта (Medium)----

4.----	SSMSда SchoolDB номли янги маълумотлар базасини яратинг

 create database SchoolDB

 use SchoolDB

 5.---	Students номли жадвал яратиш учун сўров ёзинг ва ишга туширинг. Унда қуйидаги устунлар бўлсин:
	--StudentID (INT, PRIMARY KEY),
	--Name (VARCHAR(50)),
	--Age (INT).

create table Students(StudentID int, StudentName varchar(30), studentAge int)

select *from Students

6.----	SQL Server, SSMS ва SQL ўртасидаги фарқларни тушунтиринг

SQL Server — Microsoft’нинг маълумотлар базаси билан ишловчи сервер дастури (DBMS/СУБД). Маълумотни сақлайди, ҳимоя қилади, транзакция ва репликацияни бошқаради, сўровларни бажаради.
Жадваллар, индекслар, лог файллар, транзакция хавфсизлиги (ACID), янгиланишларнинг изчиллиги, Row-Level Security (RLS), Always On (HA/DR), Columnstore индекслар ва ҳ.к. — булар SQL Server имкониятлари.

SSMS (SQL Server Management Studio) — клиент иловаси/мухит (IDE). Админ ва дастурчилар шу орқали серверга уланиб, базаларни бошқаради, T-SQL ёзади, резерв нусха/тиклаш қилади.
SSMS’да Object Explorerда базаларни кўрасиз, New Queryни очиб юқоридаги SQL кодни ишга туширасиз, Backup/Restore Wizard орқали нусха оласиз. Ўзи маълумот сақламайди — SQL Serverга команда юборади.

SQL (Structured Query Language) — сўровлар тили. Маълумотни яратиш/ўқиш/ўзгартириш учун стандарт тил (DDL, DML, DQL ва ҳ.к.).SQL — тил намунаси



-----Қийин (Hard)-----

7----.	SQL буйруқ турларини ўрганиб, изоҳланг: DQL, DML, DDL, DCL, TCL — ҳар бирига мисол келтиринг

DQL — Data Query Language (Маълумотни сўраш)
Асосий қиладиган иши: маълумотни ўқиш/қидириш, фильтрлаш, сортлаш.
Асосий оператор: SELECT (шу жумладан WHERE, JOIN, GROUP BY, ORDER BY, HAVING)

DML — Data Manipulation Language (Маълумотни ўзгартириш)
Асосий қиладиган иши: жадвалдаги маълумотни қўшиш, янгилаш, ўчириш.
Асосий операторлар: INSERT, UPDATE, DELETE, (SQL Server’da шунингдек MERGE).


DDL — Data Definition Language (Схемани таърифлаш)
Асосий қиладиган иши: объектлар (база, жадвал, индекс, view, schema) ни яратиш/ўзгартириш/ўчириш.
Асосий операторлар: CREATE, ALTER, DROP, TRUNCATE.

DCL — Data Control Language (Ҳуқуқлар/хавфсизлик)
Асосий қиладиган иши: ресурсларга рухсат бериш/қайтариб олиш.
Асосий операторлар: GRANT, REVOKE (SQL Serverда қўшимча: DENY).

TCL — Transaction Control Language (Транзакциялар бошқаруви)
Асосий қиладиган иши: DML амалларини бир бутун қилиб бошқаради — ё COMMIT (сақлаш), ё ROLLBACK (бекор қилиш).
Асосий операторлар: BEGIN TRAN[SACTION], COMMIT, ROLLBACK, SAVE TRAN.

8.---	Students жадвалига учта ёзув қўшиш учун сўров ёзинг.

insert into Students values (1,'Sardor', 22)
insert into Students values (2,'Nodir', 21)
insert into Students values (3,'Ravshan', 25)

select *from Students
