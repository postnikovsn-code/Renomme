
//
Процедура FTPСоединениеЗаписать(ИмяФайла, ДТ) Экспорт
АдресСайта = "212.176.32.173" ;
Порт = 21;
Логин = "INVINA/streg";
Пароль = "mnbvcxz*279";
ИмяКаталога = "/test/RENOME_TEST/";
FTPСоединение = Новый FTPСоединение(АдресСайта,Порт,Логин,Пароль);
FTPСоединение.УстановитьТекущийКаталог(ИмяКаталога);

//FTPСоединение.Записать("C:\BASE\"+Формат(ДТ, "ДФ=ddMMyy")+".txt",Формат(ДТ, "ДФ=ddMMyy")+".txt");
FTPСоединение.Записать(ИмяФайла, Формат(ДТ, "ДФ=ddMMyy")+".txt");
Конецпроцедуры	
//

//////////////////////////////////////////////////////////

////// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// + SQL
Функция СоединениеConnectionString__АНТОН()
НомерSQL = "";

Если НомерSQL = "Исходный" Тогда	
	Возврат "DRIVER={MySQL ODBC 5.1 Driver};OPTION=3;DATABASE=artemis;PWD=wertyu;PORT=3306;SERVER=192.168.20.100;UID=artemis;";
ИначеЕсли НомерSQL = "Новый" Тогда
	Возврат "DRIVER={MySQL ODBC 5.1 Driver};OPTION=3;DATABASE=artemis;PWD=wertyu;PORT=3306;SERVER=127.0.0.1;UID=artemis;";
ИначеЕсли НомерSQL = "Местный" Тогда
	Возврат "Provider=SQLOLEDB.1;Persist Security Info=False;User ID=postnikovsn;Password=,hfn-yjcjhju;Initial Catalog=artemis;Data Source=10.1.3.196";
//Sc.ConnectionString=
//          "Provider=SQLOLEDB.1;Persist Security Info=False;User ID=postnikovsn;Password=,hfn-yjcjhju;Initial Catalog=artemis;Data Source=10.1.3.196";
Иначе		
	Сообщить("Не указан срервер");
КонецЕсли;	
	
КонецФункции	

Функция КомандаСоединениеConnectionString()
ТипСервера = ПараметрыСеанса.ТипСервера;	
	
Если ТипСервера = "Рабочий" ИЛИ ТипСервера = "Тестовый" Тогда	
	Возврат "DRIVER={MySQL ODBC 8.0 Unicode Driver};OPTION=3;DATABASE=artemis;PWD=Wertyu12;PORT=3306;SERVER=127.0.0.1;UID=artemis;";
ИначеЕсли ТипСервера = "МойКомпьютер" Тогда
	Возврат "Provider=SQLOLEDB.1;Persist Security Info=False;User ID=postnikovsn;Password=,hfn-yjcjhju;Initial Catalog=artemis;Data Source=10.1.3.196";
Иначе		
	Сообщить("Неверный параметр определения сервера MySQL");
КонецЕсли;		
	
//Если НомерSQL = "Исходный" Тогда	
//	Возврат "DRIVER={MySQL ODBC 5.2 Unicode Driver};OPTION=3;DATABASE=artemis;PWD=wertyu;PORT=3306;SERVER=192.168.20.100;UID=artemis;";
//ИначеЕсли НомерSQL = "Новый" Тогда
//	Возврат "DRIVER={MySQL ODBC 5.2 Unicode Driver};OPTION=3;DATABASE=artemis;PWD=wertyu;PORT=3306;SERVER=127.0.0.1;UID=artemis;";
//ИначеЕсли НомерSQL = "Местный" Тогда
//	Возврат "Provider=SQLOLEDB.1;Persist Security Info=False;User ID=postnikovsn;Password=,hfn-yjcjhju;Initial Catalog=artemis;Data Source=10.1.3.196";
//Иначе		
//	Сообщить("Не указан срервер");
//КонецЕсли;	
//	
КонецФункции	

Функция ЗапросСоединениеConnectionString()
ТипСервера = ПараметрыСеанса.ТипСервера;	
	
Если ТипСервера = "Рабочий" Тогда	
	Возврат "DRIVER={MySQL ODBC 5.1 Driver};OPTION=3;DATABASE=artemis;PWD=wertyu;PORT=3306;SERVER=127.0.0.1;UID=artemis;";
	
ИначеЕсли ТипСервера = "Тестовый" Тогда
	Возврат "DRIVER={MySQL ODBC 5.1 Driver};OPTION=3;DATABASE=artemis;PWD=wertyu;PORT=3306;SERVER=192.168.20.100;UID=artemis;";
	
ИначеЕсли ТипСервера = "МойКомпьютер" Тогда
	Возврат "Provider=SQLOLEDB.1;Persist Security Info=False;User ID=postnikovsn;Password=,hfn-yjcjhju;Initial Catalog=artemis;Data Source=10.1.3.196";
Иначе		
	Сообщить("Неверный параметр определения сервера MySQL");
КонецЕсли;		
	
//Если НомерSQL = "Исходный" Тогда	
//	Возврат "DRIVER={MySQL ODBC 5.2 Unicode Driver};OPTION=3;DATABASE=artemis;PWD=wertyu;PORT=3306;SERVER=192.168.20.100;UID=artemis;";
//ИначеЕсли НомерSQL = "Новый" Тогда
//	Возврат "DRIVER={MySQL ODBC 5.2 Unicode Driver};OPTION=3;DATABASE=artemis;PWD=wertyu;PORT=3306;SERVER=127.0.0.1;UID=artemis;";
//ИначеЕсли НомерSQL = "Местный" Тогда
//	Возврат "Provider=SQLOLEDB.1;Persist Security Info=False;User ID=postnikovsn;Password=,hfn-yjcjhju;Initial Catalog=artemis;Data Source=10.1.3.196";
//Иначе		
//	Сообщить("Не указан срервер");
//КонецЕсли;	
	
КонецФункции	

Функция КомандаMySQL(ТекстЗапроса) Экспорт 
// + ПСН Отладка	
//Возврат Неопределено;
// - ПСН Отладка	

	Соединение = Новый COMОбъект("ADODB.Connection");
	
	//Соединение.ConnectionString ="DRIVER={MySQL ODBC 5.2a Driver};OPTION=3;DATABASE=artemis;PWD=wertyu;PORT=3306;SERVER=127.0.0.1;UID=artemis;";
	Соединение.ConnectionString = КомандаСоединениеConnectionString();
	
	// инициализируем набор записей и комманду
	НаборЗаписей = Новый COMОбъект("ADODB.Recordset");
	Команда = Новый COMОбъект("ADODB.Command");
	Попытка
		Соединение.Open();
	Исключение
		Сообщить("Ошибка открытия SQL: " + ОписаниеОшибки());
		Возврат Неопределено;
	КонецПопытки;
	
	Попытка
		
		Соединение.execute(ТекстЗапроса);	
		
	Исключение
		Сообщить("Ошибка обращения к SQL: " + ОписаниеОшибки()
			+ Символы.ПС + ТекстЗапроса);
		
	КонецПопытки;	  
	//  ТЗ=СКЛ_ТЗ(Table);
	//  Возврат ТЗ;
КонецФункции

Функция ЗапросMySQL(ТекстЗапроса) Экспорт 
// + ПСН Отладка	
	//ТЗ = Новый ТаблицаЗначений;
	//Возврат ТЗ;
// - ПСН Отладка	
	
	Соединение = Новый COMОбъект("ADODB.Connection");
	
	//Соединение.ConnectionString ="DRIVER={MySQL ODBC 5.2a Driver};OPTION=3;DATABASE=artemis;PWD=wertyu;PORT=3306;SERVER=127.0.0.1;UID=artemis;";
	Соединение.ConnectionString =ЗапросСоединениеConnectionString();
	
	// инициализируем набор записей и комманду
	НаборЗаписей = Новый COMОбъект("ADODB.Recordset");
	Команда = Новый COMОбъект("ADODB.Command");
	Попытка
		Соединение.Open();
	Исключение
		Сообщить("Ошибка открытия SQL: " + ОписаниеОшибки());
		
		Возврат Новый ТаблицаЗначений;
	КонецПопытки;
	
	Попытка
		Table=Соединение.execute(ТекстЗапроса);	  
	Исключение
		Сообщить("Ошибка обращения к SQL: " + ОписаниеОшибки()
					+ Символы.ПС + ТекстЗапроса);
		
		Возврат Новый ТаблицаЗначений;
	КонецПопытки;
	
	ТЗ=СКЛ_ТЗ(Table);
	Возврат ТЗ;
КонецФункции

Функция СКЛ_ТЗ(Результ) 
	ТЗ=Новый ТаблицаЗначений;
	Если Результ<>неопределено тогда
		
		
		Для сч=0 По Результ.Fields.Count-1 Цикл
			ТЗ.Колонки.Добавить(Результ.Fields(сч).Name);	
		КонецЦикла; 
		Пока Результ.EOF()=0 Цикл
			Нов=ТЗ.Добавить();
			Для сч=0 По Результ.Fields.Count-1 Цикл
				Нов[Результ.Fields(сч).Name]=Результ.Fields(сч).Value;				
			КонецЦикла; 
			
			Результ.MoveNext();			
		конеццикла;
		
	конецесли;
	Возврат ТЗ;
КонецФункции
// - SQL



