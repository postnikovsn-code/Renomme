# Сценарий: Рассылка WhatsApp (Green API)

`РассылкаWhatsApp.РассылкаWhatsApp_Сайт(ДатаРассылки)` → `МесенджерСервер.ОтправитьДанные_Месенджер` → `WhatsAppСервер` → `GREEN_WhatsApp`. 🟢
Файлы: `ПСН_РЕНОМЕ__АУДИТ/src/CommonModules/{РассылкаWhatsApp, МесенджерСервер, WhatsAppСервер, GREEN_WhatsApp}/Module.bsl`.

```mermaid
flowchart TD
    A["РассылкаWhatsApp_Сайт(ДатаРассылки)"] --> B{МесенджерСервер.МесенджерВключен()?}
    B -- нет --> B1["Сообщить 'выключено'; Возврат"]
    B -- да --> C["Запрос: выехавшие вчера гости<br/>(статус=Выехал, каналы WhatsApp/НашСайт/ОтСтойки/Телефон)<br/>ЛЕВОЕ СОЕДИНЕНИЕ РС РассылкаWhatsApp (антидубль)"]
    C --> D["Удалить строки: ЕстьРассылка ИЛИ пустой телефон"]
    D --> E["Текст = ТекстРассылки_Сайт()"]
    E --> F{Для каждого получателя}
    F -- да --> G["ОтправитьДанные_Месенджер('ОтправитьТекст', Телефон, Текст)"]
    G --> H{Результат.Ошибка?}
    H -- нет --> I["Записать РС РассылкаWhatsApp(Клиент, ДатаРассылки, Тип=Сайт)"] --> F
    H -- да --> F
    F -- нет --> Z["Конец"]

    subgraph DISP["МесенджерСервер.ОтправитьДанные_Месенджер"]
        M1["Телефон_П = GREEN_WhatsApp.ТелефонGREEN(Номер)"] --> M2{Канал WhatsApp включён?}
        M2 -- да --> M3["WhatsAppСервер.ОтправитьТекстGreenWhatsApp(Телефон_П, Текст)"]
        M2 -- нет --> M4{Канал Telegram включён?}
        M4 -- да --> M5["TelegramСервер.ОтправитьТекстGreenTelegram(...)"]
    end

    subgraph REST["GREEN_WhatsApp.ОтправитьТекст (REST)"]
        R1["Параметры = Константы.GREENIdInstance/ApiToken"] --> R2["chatId = '<номер>@c.us'"]
        R2 --> R3["Тело = JSON {chatId, message}"]
        R3 --> R4["POST https://api.green-api.com/<br/>waInstance{Инстанс}/sendMessage/{Токен}<br/>OpenSSL, Content-Type application/json"]
        R4 --> R5{КодСостояния=200?}
        R5 -- да --> R6["ПрочитатьJSON → ответ"]
        R5 -- нет --> R7["ВызватьИсключение статус+тело"]
    end
```

## Протокол Green API (`GREEN_WhatsApp`) 🟢
- Хост: `api.green-api.com` (текст/ссылки), `media.green-api.com` (файлы).
- URL метода: `waInstance<Инстанс>/<Метод>/<Токен>`. Методы: `sendMessage`, `sendLink`, `sendFileByUpload`, `checkWhatsapp`.
- Файлы — multipart/form-data ручной сборки (`ПараметрFormData`/`ФайлFormData`, MIME по расширению).
- Нормализация телефона `ТелефонGREEN`: только цифры; `8…`→`7…`; 10 цифр→`7`+номер; иначе 0.
- Идемпотентность рассылки — РС `РассылкаWhatsApp` (Клиент+ДатаРассылки+ТипРассылки).

## Пробелы
- 🟡 Хардкод e-mail ошибок `postnikov_sn@invina.ru` (`РассылкаWhatsApp:33`).
- 🔴 Telegram-токен в комментарии `TelegramСервер:4` (см. legacy-mapping).
- 🟡 Рассылка «ДеньРождения» закомментирована.
