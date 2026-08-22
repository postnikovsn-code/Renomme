# Legacy-mapping — модуль «Интеграции и обмен»

Прямые ссылки на файлы легаси, составляющие модуль. Корень: `ПСН_РЕНОМЕ__АУДИТ/src`. Шкала: 🟢 подтверждено, 🟡 выведено, 🔴 пробел.

## Планы обмена (ExchangePlans)
| Объект | Файлы | Назначение | Доверие |
|---|---|---|---|
| `ОбменГостиницы` | `ExchangePlans/ОбменГостиницы/{ОбменГостиницы.mdo, ObjectModule.bsl, Forms/ФормаУзла}` | узловой обмен между базами сети (РС БезналЗагрузка) | 🟢 |
| `ВГ_ВыпискаГостиницы` | `ExchangePlans/ВГ_ВыпискаГостиницы/{*.mdo, ObjectModule.bsl, Forms}` | обмен выписками с Бухгалтерией (узел `БУХ`), состав пуст | 🟢 |
| `ОбменТест` | `ExchangePlans/ОбменТест/{*.mdo, ObjectModule.bsl}` | тестовый план (РС Тест) | 🟡 тест |

## CommonModules — оркестрация и протокол
| Модуль | Файл | Роль | Доверие |
|---|---|---|---|
| `ОбменГостиницы` | `CommonModules/ОбменГостиницы/Module.bsl` (664) | оркестрация узлового обмена, XML-сериализация, FTP-доставка | 🟢 |
| `ОбменВыписка` | `CommonModules/ОбменВыписка/Module.bsl` (375) | сериализация `DocumentObject.Выписка` в XML (обмен, не учёт) | 🟢 |
| `ОбменБухгалтерияНДС` | `CommonModules/ОбменБухгалтерияНДС/Module.bsl` (1011) | выгрузка заявок/счетов/НДС в Бухгалтерию (XML+FTP) | 🟢 |
| `ОбменСайт` | `CommonModules/ОбменСайт/Module.bsl` (573) | HTTPS GET бронирований с сайта, JSON | 🟢 |
| `ОбменHTTP` | `CommonModules/ОбменHTTP/Module.bsl` (37) | серверная выгрузка заселений/ежедн. отчёта (источник HTTP-сервиса) | 🟢 |
| `ОбменЗаселенияСервер` | `CommonModules/ОбменЗаселенияСервер/Module.bsl` (27) | выгрузка заселений к удалению | 🟢 |
| `HTTP_Модуль` | `CommonModules/HTTP_Модуль/Module.bsl` (192) | HTTP-клиент заселений (LIVE/CHEHOV/DomSovetov/StreetArt) | 🟢 |
| `ОбменКартинкаСервер` | `CommonModules/ОбменКартинкаСервер/Module.bsl` (72) | COM-обмен картинками с базой планшета | 🟡 COM |
| `ФТПСервер` | `CommonModules/ФТПСервер/Module.bsl` | общий FTP-транспорт (FTPСоединение :21) | 🟢 |
| `МесенджерСервер` | `CommonModules/МесенджерСервер/Module.bsl` | диспетчер каналов мессенджеров | 🟢 |
| `WhatsAppСервер` | `CommonModules/WhatsAppСервер/Module.bsl` (88) | адаптер WhatsApp → Green API | 🟢 |
| `GREEN_WhatsApp` | `CommonModules/GREEN_WhatsApp/Module.bsl` (1405) | REST-клиент Green API (WhatsApp) | 🟢 |
| `РассылкаWhatsApp` | `CommonModules/РассылкаWhatsApp/Module.bsl` (356) | регламентные рассылки гостям | 🟢 |
| `TelegramСервер` | `CommonModules/TelegramСервер/Module.bsl` (167) | адаптер Telegram → Green API (через обработку) | 🟢 |
| `PayKeeper` | `CommonModules/PayKeeper/Module.bsl` (793) | REST-клиент PayKeeper, token-сессия | 🟢 |
| `PayKeeperСервер` | `CommonModules/PayKeeperСервер/Module.bsl` (1097) | оркестрация платежей, upsert в РС, привязка к долгам | 🟢 |
| `PayKeeperКлиент` / `PayKeeperКлиентСервер` | `CommonModules/PayKeeper*/Module.bsl` | клиентская обёртка, список платежей | 🟢 |
| `HttpBridgeКлиент` | `CommonModules/HttpBridgeКлиент/Module.bsl` (378) | клиентский HTTP-мост | 🟡 не разобран |

## DataProcessors
| Обработка | Путь | Роль | Доверие |
|---|---|---|---|
| `GreenAPI` | `DataProcessors/GreenAPI/` | UI/движок Green API | 🟡 |
| `GREEN_MAX` | `DataProcessors/GREEN_MAX/` | канал MAX (Green) | 🟡 |
| `GREEN_Telegram` | `DataProcessors/GREEN_Telegram/` | движок Telegram (вызывается из `TelegramСервер`) | 🟢 |
| `ВыгрузкаНДС` | `DataProcessors/ВыгрузкаНДС/` | UI выгрузки НДС | 🟡 |
| `ОбменВыписка` | `DataProcessors/ОбменВыписка/` | UI обмена выпиской | 🟡 |
| `ОбменГостинницы` | `DataProcessors/ОбменГостинницы/` | UI обмена (опечатка в имени) | 🟡 дубль |
| `Обмен_ТЕСТ` / `GREEN_Тест` | `DataProcessors/{Обмен_ТЕСТ, GREEN_Тест}/` | тестовые | 🟡 тест |
| `РассылкаWhatsApp_Сайт` / `_ДеньРождения` | `DataProcessors/РассылкаWhatsApp_*/` | UI рассылок | 🟡 |

## XDTOPackages
| Пакет | Путь | Доверие |
|---|---|---|
| `Cashbox_1_21_1` | `XDTOPackages/Cashbox_1_21_1/Package.xdto` | 🔴 схема не разобрана (граница БПО) |
| `ExchangeMessage` | `XDTOPackages/ExchangeMessage/Package.xdto` | 🔴 схема не разобрана |

## Хранилище данных
- РС `PayKeeperПлатежи`, РС `РассылкаWhatsApp`, константы `GREEN*`, `Сервер*HTTP`, флаги `СообщенияЧерез*` — см. `data-dictionary.md` → раздел «Интеграции и обмен».

## Границы (НЕ дублируется — только связь)
- ФМС/PassportBox → модуль «Гости» (`PassportBoxВызовСервера`, `ВыгрузкаДляФМС`).
- СерверККМ/фискальное оборудование → «БПО».
- `ОбменГорничныеСервер` (COM-обмен с базой горничных) → «Горничные».
- Документ «Выписка» как учётная сущность → «Финансы»; здесь — только её сериализация в обмене.

## 🔴 Секреты и пробелы (приоритетно)
| # | Где | Что | Уровень |
|---|---|---|---|
| 1 | `ФТПСервер/Module.bsl:199-202` (коммент) | FTP `212.176.32.173` / `INVINA\streg` / `mnbvcxz*279` | 🔴 секрет |
| 2 | `TelegramСервер/Module.bsl:4,20,59,120` (коммент) | Green API Telegram token `84a9441987a9415fb7f03365ffdea87b67027916c3e54405bb`, idInstance `3100530778` | 🔴 секрет |
| 3 | `ОбменКартинкаСервер/Module.bsl:8,16` | COM `Pwd="123"` | 🔴 секрет |
| 4 | `РассылкаWhatsApp/Module.bsl:33` | хардкод e-mail `postnikov_sn@invina.ru` | 🟡 |
| 5 | `HTTP_Модуль/Module.bsl:63,161` | `127.0.0.1` (закомментирован) | 🟡 |
| 6 | XDTO `.xdto` | схемы сериализации не разобраны | 🔴 |
| 7 | `ОбменКартинкаСервер` | `Перейти` (goto) для ретраев, пустые `Попытка` без логирования | 🟡 |
