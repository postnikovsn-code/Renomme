# OpenAPI — экспонируемые HTTP-контракты системы «ОТЕЛЬ»

> Глобальный артефакт Reversa (Writer, шаг «Глобальные»). Шкала доверия: 🟢 подтверждено в коде · 🟡 выведено · 🔴 пробел.
> Корень легаси: `ПСН_РЕНОМЕ__АУДИТ/src`. Связанные артефакты: `_reversa_sdd/Интеграции/contracts.md`, `_reversa_sdd/Оборудование/contracts.md`, `_reversa_sdd/Гости/contracts.md`.

## Главный вывод: система — преимущественно КОНСЮМЕР внешних API 🟢

В конфигурации «ОТЕЛЬ» **нет ни одного зарегистрированного объекта метаданных `HTTPСервис` (HTTPService) или `WebСервис` (WebService)**.

Подтверждение (🟢):
- В `ПСН_РЕНОМЕ__АУДИТ/src/` отсутствуют папки `HTTPServices/` и `WebServices/`.
- В `ПСН_РЕНОМЕ__АУДИТ/src/Configuration/Configuration.mdo` нет элементов `<httpServices>` / `<webServices>`.
- Grep по `HTTPСервис`/`HTTPService`/`RequestProcessing` не находит ни одного серверного обработчика HTTP-сервиса.

Все HTTP-взаимодействия в коде — **исходящие** (клиентские вызовы внешних REST/HTTP):
Green API (WhatsApp/Telegram/MAX), PayKeeper/СБП, сайт бронирования, «Сервер ККМ» (АТОЛ), HttpBridge-компонента оборудования, и HTTP-сервисы заселений у **соседних** баз сети отелей. Они описаны как клиентские контракты в `*/contracts.md` соответствующих модулей.

Поэтому формальная спецификация «что система экспонирует» состоит из:
1. `peer-installations-http.yaml` — **inter-base контракт** заселений/ежедневного отчёта. Эти эндпоинты ВЫЗЫВАЕТ наша база (как клиент, через `HTTP_Модуль`), но ОТДАЁТ их **другой экземпляр той же конфигурации «ОТЕЛЬ»**, развёрнутый как peer-отель (LIVE/CHEHOV/DomSovetov/StreetArt). Внутри нашей базы готовые данные для такого сервиса формируют функции `ОбменHTTP.ВыгрузитьЗаселения` / `ВыгрузитьЕжедневныйОтчетФакт` — то есть наша база ПОТЕНЦИАЛЬНО является источником этих эндпоинтов при peer-развёртывании. Спецификация даётся как документация межбазового контракта семейства «ОТЕЛЬ». 🟡

## Перечень найденного (инвентаризация HTTP-поверхности)

### A. Эндпоинты, которые наша база ВЫЗЫВАЕТ (исходящие, КОНСЮМЕР) 🟢

| Контракт | Транспорт | Точка в коде | Документ |
|----------|-----------|--------------|----------|
| HTTP-сервисы заселений соседних отелей `/{HOTEL}_HTTP/hs/products/...` | HTTP GET → JSON | `CommonModules/HTTP_Модуль/Module.bsl` | `peer-installations-http.yaml` (этот каталог) |
| Green API WhatsApp `api.green-api.com`, `media.green-api.com` | HTTPS POST JSON/multipart | `CommonModules/GREEN_WhatsApp/Module.bsl` | `Интеграции/contracts.md` C-01 |
| Green API Telegram (через `Обработка.GREEN_Telegram`) | HTTPS | `CommonModules/TelegramСервер/Module.bsl` | `Интеграции/contracts.md` C-02 |
| PayKeeper / СБП | HTTPS:443 form-urlencoded → JSON | `CommonModules/PayKeeper/Module.bsl`, `PayKeeperСервер/Module.bsl` | `Интеграции/contracts.md` C-03 |
| Обмен с сайтом (получение броней) | HTTPS:443 GET → JSON | `CommonModules/ОбменСайт/Module.bsl` | `Интеграции/contracts.md` C-04 |
| «Сервер ККМ» (АТОЛ/rbsoft) `/PrintService/api/v2/<метод>` | HTTP POST JSON, порт 4398 | `CommonModules/СерверККМ/Module.bsl` | `Оборудование/contracts.md` §1 |
| HttpBridge (внешняя компонента: Get/Post/Put/Delete) | HTTP через add-in `HttpBridge` | `CommonModules/HttpBridgeКлиент/Module.bsl` | `Оборудование/contracts.md` (БПО) |
| PassportBox (HTTP-сканер паспортов) | HTTP → JSON+картинки | `CommonModules/PassportBoxВызовСервера/Module.bsl` | `Гости/contracts.md` |

### B. Серверные функции-источники данных (НЕ обёрнуты в HTTPСервис в этой базе) 🟢

| Функция | Файл | Что отдаёт |
|---------|------|-----------|
| `ОбменHTTP.ВыгрузитьЗаселения(ДатаС, ДатаПо)` | `CommonModules/ОбменHTTP/Module.bsl:2-26` | ТЗ заселений (АвторЗаявкиКод, ВремяЗаезда) за период |
| `ОбменHTTP.ВыгрузитьЕжедневныйОтчетФакт(ДатаС, ДатаПо)` | `CommonModules/ОбменHTTP/Module.bsl:28-36` | ТЗ ежедневного отчёта-факт за период |
| `ОбменЗаселенияСервер.ВыгрузитьЗаселения_КУдалению` | `CommonModules/ОбменЗаселенияСервер/Module.bsl` | ТЗ заселений к удалению |

> 🟡 Эти функции — серверная сторона межбазового контракта заселений. При peer-развёртывании их вызывает HTTP-сервис другой инсталляции (имя сервиса в URL — `LIVE_HTTP`/`CHEHOV_HTTP`/`DomSovetov_HTTP`/`StreetArt_HTTP`, путь `hs/products/get_product` и `hs/products/get_Report_1`). Сам объект `HTTPСервис` в анализируемой базе не найден — он либо находится в другой инсталляции семейства, либо реализован вне разобранного слоя. 🔴

### C. Прочие протоколы обмена (НЕ HTTP — для полноты, в OpenAPI не описываются)

- Узловой обмен 1С (планы обмена `ОбменГостиницы`, `ВГ_ВыпискаГостиницы`) — XML + FTP. См. `Интеграции/contracts.md` C-06.
- COM-обмен (горничные, картинки, загрузка номеров/клиентов из соседних баз). См. `Горничные/`, `Размещение/`, `Интеграции/` contracts/legacy-mapping.

## Файлы каталога

- `peer-installations-http.yaml` — OpenAPI 3.0 межбазового контракта заселений/ежедневного отчёта (LIVE/CHEHOV/DomSovetov/StreetArt).
- `hotel-http-services.yaml` — заглушка-агрегатор: сводка того, что система экспонирует (фактически: ничего на уровне метаданных) + ссылка на peer-контракт.
