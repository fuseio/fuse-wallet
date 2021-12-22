// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru_RU locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru_RU';

  static String m0(amount) =>
      "Backup your wallet now and get ${amount} Fuse tokens!";

  static String m1(name) => "Привет ${name}";

  static String m2(name) =>
      "Отправив деньги пользователю ${name}, он автоматически получит приглашение во Fuse и позволит получить отправленные вами средства.\n";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "Invite_a_friend":
            MessageLookupByLibrary.simpleMessage("Реферальная программа"),
        "Invite_a_friend_1": MessageLookupByLibrary.simpleMessage(
            "1. Отправь приглашение всем своим друзьям и членам семьи!"),
        "Invite_a_friend_2": MessageLookupByLibrary.simpleMessage(
            "Они должны пополнить баланс на любую сумму дебетовой/кредитной картой, банковским переводом или через Ethereum/BSC мост"),
        "Invite_a_friend_3": MessageLookupByLibrary.simpleMessage(
            "*Регистрации с использованием телефонных номеров которые уже имеют аккаунт в сети Fuse не будут считаться реферальными"),
        "Invite_a_friend_4": MessageLookupByLibrary.simpleMessage(
            "**Максимальная сумма депозита за которую ты можешь получить бонус эквивалентна 500\$ "),
        "Invite_a_friend_5": MessageLookupByLibrary.simpleMessage(
            "***Токены участвующие в программе: fUSD; USDC; USDT; WETH; WBTC; BNB"),
        "Invite_a_friend_6": MessageLookupByLibrary.simpleMessage(
            "3. Реферальный бонус будет предоставлен токенами FUSE только на первый депозит"),
        "Invite_a_friend_button":
            MessageLookupByLibrary.simpleMessage("Пригласить"),
        "WC_connect_to_wallet": MessageLookupByLibrary.simpleMessage(
            "желает подключить ваш кошелёк"),
        "WC_desc_one": MessageLookupByLibrary.simpleMessage(
            "Посмотреть баланс кошелька и активности"),
        "WC_desc_two": MessageLookupByLibrary.simpleMessage(
            "Запрос на одобрение транзакции"),
        "about": MessageLookupByLibrary.simpleMessage("О нас"),
        "account": MessageLookupByLibrary.simpleMessage("Аккаунт"),
        "action_bonus": MessageLookupByLibrary.simpleMessage("Получено"),
        "action_claimApy": MessageLookupByLibrary.simpleMessage("Изъято"),
        "action_depositInitiated":
            MessageLookupByLibrary.simpleMessage("В ожидании на Ramp.network"),
        "action_fiatDeposit": MessageLookupByLibrary.simpleMessage("Внесено"),
        "action_receive": MessageLookupByLibrary.simpleMessage("Получено"),
        "action_send": MessageLookupByLibrary.simpleMessage("Отправлено"),
        "action_swap": MessageLookupByLibrary.simpleMessage("Обменяно"),
        "activate": MessageLookupByLibrary.simpleMessage("Активировать"),
        "activity": MessageLookupByLibrary.simpleMessage("История операций"),
        "add_cash": MessageLookupByLibrary.simpleMessage("Внести наличные"),
        "address": MessageLookupByLibrary.simpleMessage("Адрес"),
        "address_on_fuse": MessageLookupByLibrary.simpleMessage(
            "Please make sure the address you are sending funds to is on the Fuse Network."),
        "address_on_other": MessageLookupByLibrary.simpleMessage(
            "To send funds between Fuse and other networks like Ethereum of BSC please use the link below:"),
        "amount": MessageLookupByLibrary.simpleMessage("Сумма"),
        "annual_yield": MessageLookupByLibrary.simpleMessage("50% годовых!"),
        "approve": MessageLookupByLibrary.simpleMessage("Разрешить"),
        "approved": MessageLookupByLibrary.simpleMessage("Одобренно"),
        "apy_explained_1": MessageLookupByLibrary.simpleMessage(
            "Программа заработка Fuse Dollar - это программа сбережений для всех, у кого есть баланс fUSD (Fuse Dollar)"),
        "apy_explained_2": MessageLookupByLibrary.simpleMessage(
            "Программа заработка позволяет любому пользователю Fuse Cash получить доступ к DeFi и получать доход без необходимости иметь дело с минимумами, комиссиями и другими ограничениями"),
        "apy_explained_3": MessageLookupByLibrary.simpleMessage(
            "Раз в неделю пользователи могут выкупить свой заработок без блокировок и не дожидаясь конца года!"),
        "assets_and_contracts":
            MessageLookupByLibrary.simpleMessage("Активы и контракты"),
        "auth_failed_message": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, попробуй еще раз, чтобы продолжить\n"),
        "auth_failed_title":
            MessageLookupByLibrary.simpleMessage("Ошибка аутентификации"),
        "available": MessageLookupByLibrary.simpleMessage("доступно"),
        "back_up":
            MessageLookupByLibrary.simpleMessage("Резервное копирование"),
        "back_up_now": MessageLookupByLibrary.simpleMessage(
            "Сделайте резервную копию сейчас"),
        "backup_wallet":
            MessageLookupByLibrary.simpleMessage("Резервное копирование"),
        "backup_wallet_now": m0,
        "balance": MessageLookupByLibrary.simpleMessage("Баланс"),
        "bonus": MessageLookupByLibrary.simpleMessage("Бонус"),
        "bridge_from_BSC": MessageLookupByLibrary.simpleMessage(
            "Перемещайте ETH или BNB через мост с Binance Smart Chain"),
        "bridge_from_ethereum": MessageLookupByLibrary.simpleMessage(
            "Перемещайте цифровые активы из сети Ethereum"),
        "bridge_to": MessageLookupByLibrary.simpleMessage("Переправить на"),
        "buy": MessageLookupByLibrary.simpleMessage("Купить"),
        "camera": MessageLookupByLibrary.simpleMessage("Камера"),
        "cancel": MessageLookupByLibrary.simpleMessage("Отмена"),
        "choose_lock_method": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, выбери, как ты предпочитаешь защитить свой кошелек, выбрав следующие методы"),
        "claim": MessageLookupByLibrary.simpleMessage("Забрать прямо сейчас!"),
        "close": MessageLookupByLibrary.simpleMessage("Закрыть"),
        "coins": MessageLookupByLibrary.simpleMessage("Монеты"),
        "collectibles":
            MessageLookupByLibrary.simpleMessage("Коллекционные активы"),
        "coming_soon":
            MessageLookupByLibrary.simpleMessage("Скоро станет доступным\n"),
        "community": MessageLookupByLibrary.simpleMessage("сообщество"),
        "community_address":
            MessageLookupByLibrary.simpleMessage("Адрес Сообщества"),
        "community_webpage":
            MessageLookupByLibrary.simpleMessage("Веб-страница сообщества"),
        "confirmed": MessageLookupByLibrary.simpleMessage("ПОДТВЕРЖДЕННО"),
        "congratulations": MessageLookupByLibrary.simpleMessage(
            "Вы успешно забрали средства. Заработанные Fuse Dollar в пути!"),
        "connect": MessageLookupByLibrary.simpleMessage("Подключиться"),
        "connect_to_apps":
            MessageLookupByLibrary.simpleMessage("Подключиться к приложениям"),
        "connection": MessageLookupByLibrary.simpleMessage(
            "исправьте подключение к Интернету и попробуйте еще раз!"),
        "contact_us": MessageLookupByLibrary.simpleMessage("Получить помощь"),
        "contact_us_for_support":
            MessageLookupByLibrary.simpleMessage("Получить помощь"),
        "continue_button": MessageLookupByLibrary.simpleMessage("Продолжить"),
        "continue_with": MessageLookupByLibrary.simpleMessage("Продолжить с"),
        "contract_version":
            MessageLookupByLibrary.simpleMessage("Contract version"),
        "copied_to_clipboard":
            MessageLookupByLibrary.simpleMessage("Скопировано в буфер обмена"),
        "copy_to_clipboard":
            MessageLookupByLibrary.simpleMessage("Скопировать в буфер обмена"),
        "create__wallet":
            MessageLookupByLibrary.simpleMessage("Создать кошелек"),
        "create_new_wallet":
            MessageLookupByLibrary.simpleMessage("Создать новый кошелек"),
        "create_passcode":
            MessageLookupByLibrary.simpleMessage("Создайте свой пароль"),
        "credit_card": MessageLookupByLibrary.simpleMessage("Кредитная карта"),
        "crypto_deposit_bsc": MessageLookupByLibrary.simpleMessage(
            "Если у тебя есть ETH, BNB или FUSE в сети Binance Smart Chain (BSC), используй приведенный ниже URL-адрес и подключи свой кошелёк используя WalletConnect чтобы внести депозит в Fuse:"),
        "crypto_deposit_eth": MessageLookupByLibrary.simpleMessage(
            "Если у тебя есть USDC в сети Ethereum, используй приведенный ниже URL-адрес и подключи свой кошелёк используя WalletConnect чтобы внести депозит в Fuse:"),
        "crypto_deposit_risk": MessageLookupByLibrary.simpleMessage(
            "Обрати внимание, что это персональная ссылка, по которой средства будут переведены прямо на твой счет."),
        "crypto_deposit_risk_2": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, используй его ответственно и на свой собственный риск."),
        "current_community":
            MessageLookupByLibrary.simpleMessage("Текущее сообщество"),
        "date_and_time": MessageLookupByLibrary.simpleMessage("Дата и время"),
        "deposit": MessageLookupByLibrary.simpleMessage("Депозит"),
        "deposit_and_receive_bonus": MessageLookupByLibrary.simpleMessage(
            "Внеси Fuse Dollar и зарабатывай 50% годовых!"),
        "deposit_bonus_explained": MessageLookupByLibrary.simpleMessage(
            "Ограниченное предложение. Получай 50% годовых на свой депозит в Fuse Cash!"),
        "deposit_dollars":
            MessageLookupByLibrary.simpleMessage("Внести доллары"),
        "deposit_failed":
            MessageLookupByLibrary.simpleMessage("не удалось внести средства"),
        "deposit_from_BSC":
            MessageLookupByLibrary.simpleMessage("Пополнить счет с BSC\n"),
        "deposit_from_ethereum":
            MessageLookupByLibrary.simpleMessage("Пополнить счет с Ethereum"),
        "deposit_from_ethereum_or_BSC": MessageLookupByLibrary.simpleMessage(
            "Пополнить счет через Ethereum или BSC"),
        "deposit_fusd":
            MessageLookupByLibrary.simpleMessage("Внести Fuse Доллары"),
        "deposit_fuse_dollar":
            MessageLookupByLibrary.simpleMessage("Внести Fuse Dollar"),
        "deposit_your": MessageLookupByLibrary.simpleMessage("Внесите свой"),
        "deposit_your_first_dollars":
            MessageLookupByLibrary.simpleMessage("Внесите свои первые доллары"),
        "didnt_get_message":
            MessageLookupByLibrary.simpleMessage("Не получили сообщение?"),
        "dismiss": MessageLookupByLibrary.simpleMessage("Убрать"),
        "dont_close_the_app":
            MessageLookupByLibrary.simpleMessage("Не закрывайте приложение"),
        "dont_show_next_time":
            MessageLookupByLibrary.simpleMessage("Больше не показывать"),
        "dont_worry": MessageLookupByLibrary.simpleMessage("Не волнуйтесь:"),
        "earn": MessageLookupByLibrary.simpleMessage("Зарабатывай"),
        "earn_apr":
            MessageLookupByLibrary.simpleMessage("Зарабатывайте 50% годовых"),
        "earn_description": MessageLookupByLibrary.simpleMessage(
            "Держатели Fuse Dollar имеют право получать доход в размере 50% в год, просто храня эту цифровую валюту на своем балансе."),
        "earn_free_dollars": MessageLookupByLibrary.simpleMessage(
            "Зарабатывай бесплатные доллары 💸"),
        "earned_apy": MessageLookupByLibrary.simpleMessage("Заработок"),
        "earned_so_far":
            MessageLookupByLibrary.simpleMessage("Заработано на данный момент"),
        "earnings_received": MessageLookupByLibrary.simpleMessage(
            "Заработанные Fuse Dollar получены!"),
        "edit": MessageLookupByLibrary.simpleMessage("Править"),
        "enable_contacts_access":
            MessageLookupByLibrary.simpleMessage("Включить доступ к контактам"),
        "enable_contacts_text": MessageLookupByLibrary.simpleMessage(
            "Включить синхронизацию контактов для отправки средств на телефонные контакты"),
        "enable_text": MessageLookupByLibrary.simpleMessage(
            "Твои контакты не будут сохранены на нашем сервере, и это действие не отправит им сообщения"),
        "enter_community_address":
            MessageLookupByLibrary.simpleMessage("Введите адрес сообщества"),
        "enter_phone_number": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, введи свой номер телефона для настройки учетной записи"),
        "enter_pincode":
            MessageLookupByLibrary.simpleMessage("Введите свой PIN-код:"),
        "enter_verification_code": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, введи 6-значный код из этого сообщение здесь"),
        "error": MessageLookupByLibrary.simpleMessage("Ошибка"),
        "face_id": MessageLookupByLibrary.simpleMessage("Face ID"),
        "failed": MessageLookupByLibrary.simpleMessage("ЧТО-ТО ПОШЛО НЕ ТАК"),
        "fee_amount": MessageLookupByLibrary.simpleMessage("Сумма комиссии:"),
        "feed": MessageLookupByLibrary.simpleMessage("Лента"),
        "first_dollars": MessageLookupByLibrary.simpleMessage("первые доллары"),
        "flash_off": MessageLookupByLibrary.simpleMessage("Вспышка выключена"),
        "flash_on": MessageLookupByLibrary.simpleMessage("Вспышка включена"),
        "follow_us_on_twitter": MessageLookupByLibrary.simpleMessage(
            "Подпишись на нас в Twitter\n"),
        "for_more_info": MessageLookupByLibrary.simpleMessage(
            "Для дополнительной информации:"),
        "for_text": MessageLookupByLibrary.simpleMessage("для"),
        "free": MessageLookupByLibrary.simpleMessage("Бесплатно"),
        "friend": MessageLookupByLibrary.simpleMessage("друг"),
        "from": MessageLookupByLibrary.simpleMessage("От"),
        "fusd_stablecoins_explain": MessageLookupByLibrary.simpleMessage(
            "Fuse Доллар - первая стабильная монета Fuse. В будущем мы планируем добавить больше стабильых монет, привязанные к другим основным валютам для поддержки принятие пользователями и уменьшить коверсионное трение при использовании по всему миру. Следите за обновлениями!"),
        "fuse_dollar": MessageLookupByLibrary.simpleMessage("Fuse Dollar"),
        "fuse_dollar_explain": MessageLookupByLibrary.simpleMessage(
            "Fuse Dollar (fUSD) - это стабильная валюта привязанная к доллару США, созданная на блокчейне Fuse Network. Она была создана, чтобы упростить криптовалюту и DeFi для ежедневных пользователей."),
        "fuse_network": MessageLookupByLibrary.simpleMessage("Fuse network"),
        "fuse_studio": MessageLookupByLibrary.simpleMessage(
            "Вы можете перейти в новое сообщество, введя свой Asset ID (доступный в Fuse Studio) или отсканировав QR-код."),
        "future_stablecoins":
            MessageLookupByLibrary.simpleMessage("Будущие стабильные монеты"),
        "gallery": MessageLookupByLibrary.simpleMessage("Галерея"),
        "generate_wallet_failed":
            MessageLookupByLibrary.simpleMessage("Не удалось создать кошелек"),
        "generated_wallet": MessageLookupByLibrary.simpleMessage(
            "Добро пожаловать в кошелек Fuse"),
        "generating_wallet":
            MessageLookupByLibrary.simpleMessage("Создание fuse кошелька"),
        "gift_a_friend": MessageLookupByLibrary.simpleMessage("Gift a friend"),
        "gift_a_friend_explained": MessageLookupByLibrary.simpleMessage(
            "Test the new invite feature and get 5\$ reward"),
        "greetTo": m1,
        "hi": MessageLookupByLibrary.simpleMessage("Здравствуйте"),
        "home": MessageLookupByLibrary.simpleMessage("Домой "),
        "how_much": MessageLookupByLibrary.simpleMessage("Сколько?"),
        "how_to_use_fusd": MessageLookupByLibrary.simpleMessage(
            "Как вы можете использовать Fuse Dollar?"),
        "important": MessageLookupByLibrary.simpleMessage("Важно!"),
        "important_update":
            MessageLookupByLibrary.simpleMessage("Новая версия!"),
        "initializing_wallet": MessageLookupByLibrary.simpleMessage(
            "Инициализация кошелька на Fuse"),
        "insufficient_fund":
            MessageLookupByLibrary.simpleMessage("Недостаточно средств"),
        "intro_text_one": MessageLookupByLibrary.simpleMessage(
            "Платите и получайте средства, или отправляйте их друзьям без комиссий и лишних хлопот"),
        "intro_text_three": MessageLookupByLibrary.simpleMessage(
            "Создайте безопасную учетную запись для смарт токена чтобы получить доступ к децентрализованным финансам"),
        "intro_text_two": MessageLookupByLibrary.simpleMessage(
            "Внесите \$ и обменивайте его на другие валюты практически без комиссии"),
        "invalid_mnemonic":
            MessageLookupByLibrary.simpleMessage("Invalid mnemonic"),
        "invalid_number":
            MessageLookupByLibrary.simpleMessage("Неправильный номер"),
        "invalid_pincode":
            MessageLookupByLibrary.simpleMessage("Неверный пин-код"),
        "invalid_qa_code":
            MessageLookupByLibrary.simpleMessage("Недействительный код\n"),
        "invite_friend":
            MessageLookupByLibrary.simpleMessage("Реферальная программа"),
        "invite_friend_text": MessageLookupByLibrary.simpleMessage(
            "Зарабатывай до 50% годовых на свой депозит вместе с Fuse Cash  💸"),
        "invite_text": m2,
        "join_bonus": MessageLookupByLibrary.simpleMessage(
            "У вас есть бонус за присоединение!"),
        "join_earn_program": MessageLookupByLibrary.simpleMessage(
            "Участвовать в программе заработка"),
        "join_our_referral_program":
            MessageLookupByLibrary.simpleMessage("Join our referral program"),
        "joined": MessageLookupByLibrary.simpleMessage("Присоединено"),
        "joined_community": MessageLookupByLibrary.simpleMessage(""),
        "joining": MessageLookupByLibrary.simpleMessage("Присоединение"),
        "joining_community":
            MessageLookupByLibrary.simpleMessage("Присоединение к сообществу"),
        "language": MessageLookupByLibrary.simpleMessage("Язык"),
        "learn_about_fuse_dollar":
            MessageLookupByLibrary.simpleMessage("Узнать больше о Fuse Dollar"),
        "learn_more": MessageLookupByLibrary.simpleMessage("Узнать больше"),
        "legal": MessageLookupByLibrary.simpleMessage("Права"),
        "lets_start":
            MessageLookupByLibrary.simpleMessage("Это все! Давайте начнем"),
        "limit_discalimer":
            MessageLookupByLibrary.simpleMessage("(для депозитов свыше 200\$)"),
        "limit_offer": MessageLookupByLibrary.simpleMessage(
            "Ограниченное предложение! Бонус на депозит 50 \$ 💸"),
        "limited_time_offer":
            MessageLookupByLibrary.simpleMessage("Ограниченное предложение"),
        "login": MessageLookupByLibrary.simpleMessage("Авторизоваться"),
        "logout": MessageLookupByLibrary.simpleMessage("Выйти"),
        "map": MessageLookupByLibrary.simpleMessage("Карта"),
        "max": MessageLookupByLibrary.simpleMessage("Макс"),
        "min_to_claim": MessageLookupByLibrary.simpleMessage(
            "Минимальная сумма изъятия - 0.01\$"),
        "move_to": MessageLookupByLibrary.simpleMessage("Перейти к"),
        "my_communities":
            MessageLookupByLibrary.simpleMessage("Мои сообщества"),
        "my_referrals": MessageLookupByLibrary.simpleMessage("Мои рефералы:"),
        "name": MessageLookupByLibrary.simpleMessage("Имя"),
        "network": MessageLookupByLibrary.simpleMessage("Сеть"),
        "network_fee": MessageLookupByLibrary.simpleMessage("Комиссия сети\n"),
        "new_word": MessageLookupByLibrary.simpleMessage("New!"),
        "next_button": MessageLookupByLibrary.simpleMessage("Следующий"),
        "next_claim": MessageLookupByLibrary.simpleMessage("Следующее изъятие"),
        "next_claim_on":
            MessageLookupByLibrary.simpleMessage("Следующее изъятие"),
        "no": MessageLookupByLibrary.simpleMessage("Нет"),
        "no_activity": MessageLookupByLibrary.simpleMessage("Нет активности"),
        "no_businesses":
            MessageLookupByLibrary.simpleMessage("Не найдено предприятий"),
        "no_funds_available":
            MessageLookupByLibrary.simpleMessage("Нет доступных средств"),
        "no_results_found":
            MessageLookupByLibrary.simpleMessage("No results found for"),
        "no_swap_option": MessageLookupByLibrary.simpleMessage(
            "У вас пока нет токенов для обмена"),
        "not_connected":
            MessageLookupByLibrary.simpleMessage("No internet connection"),
        "not_enough_balance": MessageLookupByLibrary.simpleMessage(
            "Недостаточный баланс на счету"),
        "offline":
            MessageLookupByLibrary.simpleMessage("кажется, вы не в сети"),
        "ok": MessageLookupByLibrary.simpleMessage("Хорошо"),
        "ok_thanks": MessageLookupByLibrary.simpleMessage("Хорошо, спасибо"),
        "oops": MessageLookupByLibrary.simpleMessage("Ой"),
        "or": MessageLookupByLibrary.simpleMessage("или"),
        "participation_explained": MessageLookupByLibrary.simpleMessage(
            "Участвуя в программе, ты автоматически получаешь доход 50% годовых на баланса Fuse Dollar."),
        "pay": MessageLookupByLibrary.simpleMessage("ОПЛАТИТЬ"),
        "pay_with": MessageLookupByLibrary.simpleMessage("Обменять"),
        "peg_explain": MessageLookupByLibrary.simpleMessage(
            "Fuse Dollar полностью привязан к USD Coin (USDC) на Fuse. Выпущенный circle.com, USDC - это регулируемая стабильная монета, полностью обеспеченная долларом и широко признанная в сфере криптовалют."),
        "pending": MessageLookupByLibrary.simpleMessage("В ОЖИДАНИИ"),
        "phoneNumber": MessageLookupByLibrary.simpleMessage("Телефонный номер"),
        "phrase_invaild": MessageLookupByLibrary.simpleMessage(
            "One of the 12 words is invalid"),
        "pickup_display_name": MessageLookupByLibrary.simpleMessage(
            "Выберите свое отображаемое имя"),
        "pickup_display_name_text": MessageLookupByLibrary.simpleMessage(
            "Это имя будет показано контактам, которые отправляют тебе деньги, для идентификации твоей учетной записи."),
        "pincode": MessageLookupByLibrary.simpleMessage("Пин-код"),
        "pincode_dont_match":
            MessageLookupByLibrary.simpleMessage("PIN-код не совпадает"),
        "please_choose_security": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста, выбери способ разблокировки кошелька:"),
        "please_restore_your_wallet":
            MessageLookupByLibrary.simpleMessage("Please restore your wallet"),
        "please_use":
            MessageLookupByLibrary.simpleMessage("Пожалуйста, используй"),
        "price": MessageLookupByLibrary.simpleMessage("Цена"),
        "privacy": MessageLookupByLibrary.simpleMessage("Fuse.io/privacy"),
        "protect_wallet":
            MessageLookupByLibrary.simpleMessage("Защити свой кошелек"),
        "rate": MessageLookupByLibrary.simpleMessage("Обменный курс"),
        "rate_us": MessageLookupByLibrary.simpleMessage("Оцените нас\n"),
        "re_type_passcode":
            MessageLookupByLibrary.simpleMessage("Введите пароль еще раз"),
        "read_more": MessageLookupByLibrary.simpleMessage("Подробнее"),
        "receive": MessageLookupByLibrary.simpleMessage("Получить"),
        "receive_from": MessageLookupByLibrary.simpleMessage("Получить от"),
        "receive_gift":
            MessageLookupByLibrary.simpleMessage("Получить Подарок"),
        "received": MessageLookupByLibrary.simpleMessage("Получено"),
        "received_from_ethereum":
            MessageLookupByLibrary.simpleMessage("Получено из Ethereum"),
        "receiving": MessageLookupByLibrary.simpleMessage("Получение"),
        "recent": MessageLookupByLibrary.simpleMessage("Недавнее"),
        "recommended": MessageLookupByLibrary.simpleMessage("Рекомендуемые"),
        "refer_your_friends":
            MessageLookupByLibrary.simpleMessage("Пригласите своих друзей"),
        "referral_bonus":
            MessageLookupByLibrary.simpleMessage("Реферальный бонус"),
        "referral_explained": MessageLookupByLibrary.simpleMessage(
            "Пригласи друзей и получи реферальный бонус 5% от их депозитов!"),
        "reject": MessageLookupByLibrary.simpleMessage("Отклонить"),
        "resend_code":
            MessageLookupByLibrary.simpleMessage("Отправить код еще раз"),
        "reset_account": MessageLookupByLibrary.simpleMessage(
            "Создание новой учетной записи приведет к сбросу существующей учетной записи. Вы уверены, что хотите продолжить?"),
        "restore": MessageLookupByLibrary.simpleMessage("Restore"),
        "restore_backup": MessageLookupByLibrary.simpleMessage(
            "Восстановление резервной копии"),
        "restore_from_backup": MessageLookupByLibrary.simpleMessage(
            "Восстановить из резервной копии"),
        "restore_words": MessageLookupByLibrary.simpleMessage(
            "Это фраза из 12 слов, которую вам дали при создании предыдущего кошелька."),
        "review_swap": MessageLookupByLibrary.simpleMessage("Проверка деталей"),
        "review_trade": MessageLookupByLibrary.simpleMessage(""),
        "review_transfer":
            MessageLookupByLibrary.simpleMessage("Просмотреть перевод"),
        "reward_for_deposits": MessageLookupByLibrary.simpleMessage(
            "Внеси 200\$ или больше и получи в награду 50\$"),
        "save_button": MessageLookupByLibrary.simpleMessage("Сохранить"),
        "scan_address": MessageLookupByLibrary.simpleMessage(
            "Отсканируй QR-код адреса в сети Fuse чтобы отправить деньги"),
        "scan_to_receive": MessageLookupByLibrary.simpleMessage(
            "Отсканируйте QR-код, чтобы получить деньги"),
        "scan_wallet_connect": MessageLookupByLibrary.simpleMessage(
            "Отсканируй QR-код WalletConnect"),
        "search": MessageLookupByLibrary.simpleMessage("Имя или адрес"),
        "selected": MessageLookupByLibrary.simpleMessage("Выбрано"),
        "sell": MessageLookupByLibrary.simpleMessage("Продать"),
        "send": MessageLookupByLibrary.simpleMessage("Отправить"),
        "send_button": MessageLookupByLibrary.simpleMessage("Отправить"),
        "send_funds":
            MessageLookupByLibrary.simpleMessage("Отправить средства"),
        "send_to": MessageLookupByLibrary.simpleMessage("Отправить"),
        "send_to_address":
            MessageLookupByLibrary.simpleMessage("Отправить по адресу"),
        "send_to_your_vault":
            MessageLookupByLibrary.simpleMessage("Send to your vault"),
        "sending_on_fuse": MessageLookupByLibrary.simpleMessage(
            "Please make sure you are sending assets on the"),
        "sending_to_ethereum": MessageLookupByLibrary.simpleMessage(
            "Отправлено на твой Ethereum кошелек"),
        "sent": MessageLookupByLibrary.simpleMessage("Отправлено"),
        "sent_to": MessageLookupByLibrary.simpleMessage("Отправить\n"),
        "sent_to_ethereum":
            MessageLookupByLibrary.simpleMessage("Отправлено в Ethereum"),
        "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
        "share_button": MessageLookupByLibrary.simpleMessage("Поделится"),
        "sign_up": MessageLookupByLibrary.simpleMessage("Зарегистрироваться"),
        "simple": MessageLookupByLibrary.simpleMessage("Простой"),
        "skip_button": MessageLookupByLibrary.simpleMessage("Пропустить"),
        "slippage": MessageLookupByLibrary.simpleMessage("Проскальзывание"),
        "smart": MessageLookupByLibrary.simpleMessage("Умный"),
        "social": MessageLookupByLibrary.simpleMessage("Социальные сети"),
        "some_services_are_down": MessageLookupByLibrary.simpleMessage(
            "We\'re having issues with one of our services"),
        "something_went_wrong":
            MessageLookupByLibrary.simpleMessage("Что-то пошло не так"),
        "sqan_qr_code": MessageLookupByLibrary.simpleMessage(
            "Отсканируйте QR, чтобы переключиться"),
        "start_earning":
            MessageLookupByLibrary.simpleMessage("Начать зарабатывать"),
        "stores_private": MessageLookupByLibrary.simpleMessage(
            "Кошелек Fuse хранит личную информацию локально на устройстве. Только номер телефона используется для подтверждения твоей личности для уменьшения неудобств при отправке денег по телефонным контактам."),
        "success": MessageLookupByLibrary.simpleMessage("Успешно"),
        "support": MessageLookupByLibrary.simpleMessage("Support"),
        "swap": MessageLookupByLibrary.simpleMessage("Обмен"),
        "swapped": MessageLookupByLibrary.simpleMessage("Обмен совершен"),
        "swapping": MessageLookupByLibrary.simpleMessage("Обмениваем"),
        "switch_community":
            MessageLookupByLibrary.simpleMessage("Сменить сообщество"),
        "sync_contacts":
            MessageLookupByLibrary.simpleMessage("Синхронизация контактов"),
        "sync_your_contacts": MessageLookupByLibrary.simpleMessage(
            "Синхронизируйте свой контакт"),
        "ten_seconds": MessageLookupByLibrary.simpleMessage("(до 10 секунд)"),
        "terms_conditions": MessageLookupByLibrary.simpleMessage(
            "Нажми, чтобы развернуть Условия программы"),
        "thank_you": MessageLookupByLibrary.simpleMessage("Спасибо"),
        "thank_you_for_your_patience":
            MessageLookupByLibrary.simpleMessage("Спасибо за терпение"),
        "thats_it": MessageLookupByLibrary.simpleMessage("Вот и всё"),
        "to": MessageLookupByLibrary.simpleMessage("Кому"),
        "to_protect": MessageLookupByLibrary.simpleMessage(
            "Чтобы защитить свои деньги и кошелек, перейди в настройки и сделай резервную копию своего кошелька за несколько простых шагов."),
        "to_unlock": MessageLookupByLibrary.simpleMessage("чтобы открыть!"),
        "token": MessageLookupByLibrary.simpleMessage("Токен"),
        "top_up": MessageLookupByLibrary.simpleMessage("Пополнить"),
        "top_up_your_account":
            MessageLookupByLibrary.simpleMessage("Пополните свой счет"),
        "total_amount": MessageLookupByLibrary.simpleMessage("Общая сумма:"),
        "total_reward": MessageLookupByLibrary.simpleMessage("Общая награда:"),
        "touch_id": MessageLookupByLibrary.simpleMessage("Touch ID"),
        "trade": MessageLookupByLibrary.simpleMessage(""),
        "transaction_details":
            MessageLookupByLibrary.simpleMessage("Детали транзакции"),
        "transaction_failed":
            MessageLookupByLibrary.simpleMessage("Транзакция не удалась"),
        "transactions": MessageLookupByLibrary.simpleMessage("Транзакции"),
        "try_again": MessageLookupByLibrary.simpleMessage("Попробуйте еще раз"),
        "txn": MessageLookupByLibrary.simpleMessage("Txn"),
        "up_to_10": MessageLookupByLibrary.simpleMessage("(до 10 секунд)"),
        "update": MessageLookupByLibrary.simpleMessage("Обновить"),
        "update_process":
            MessageLookupByLibrary.simpleMessage("Процесс обновления..."),
        "upgrade_wallet_text": MessageLookupByLibrary.simpleMessage(
            "Контракт кошелька необходимо обновить, чтобы заработали новые функции"),
        "upgrade_wallet_time": MessageLookupByLibrary.simpleMessage(
            "Нажмите \"Обновить\", чтобы сделать это. Это займет около 10 секунд. "),
        "use_fusd_explain": MessageLookupByLibrary.simpleMessage(
            "Fuse Доллары можно свободно перемещать между счетами на Fuse Cash, а также на счета Fuse вне Fuse Cash кошелька. Их также можно обменять на другие криптовалюты прямо в кошельке Fuse Cash с помощью FuseSwap DEX, и вскоре их можно будет использовать для получения пассивного дохода."),
        "use_max": MessageLookupByLibrary.simpleMessage("Используйте макс."),
        "useful": MessageLookupByLibrary.simpleMessage("Полезный"),
        "version": MessageLookupByLibrary.simpleMessage("Версия приложения"),
        "visit_fuseio": MessageLookupByLibrary.simpleMessage(
            "Посетите fuse.io, чтобы узнать больше о Fuse и о том, как все работает за кулисами."),
        "waiting_for_deposit":
            MessageLookupByLibrary.simpleMessage("Жду прибытия депозита"),
        "wallet": MessageLookupByLibrary.simpleMessage("Кошелек"),
        "wallet_address":
            MessageLookupByLibrary.simpleMessage("Адрес кошелька"),
        "wallet_protected": MessageLookupByLibrary.simpleMessage(
            "Теперь твой Fuse кошелек защищен!"),
        "wallet_protected_text": MessageLookupByLibrary.simpleMessage(
            "Отлично, вы подтвердили свою секретную фразу. Не забывайте хранить её в надежном месте и никогда никому не показывать."),
        "want_to_earn_more":
            MessageLookupByLibrary.simpleMessage("Хотите заработать больше?"),
        "we_just_sent": MessageLookupByLibrary.simpleMessage(
            "Мы только что отправили вам сообщение"),
        "we_notice": MessageLookupByLibrary.simpleMessage(
            "Мы заметили, что вы еще не сделали резервную копию своего кошелька."),
        "welcome_to_fuse": MessageLookupByLibrary.simpleMessage(
            "Добро подаловать в кошелёк Fuse!"),
        "welcome_to_fuse_text": MessageLookupByLibrary.simpleMessage(
            "Покупай, Меняй, Отправляй и Зарабатывай криптовалюты без комиссии"),
        "welcome_to_wallet": MessageLookupByLibrary.simpleMessage(
            "Добро пожаловать в кошелёк fuse.cash"),
        "what_is_fuse_dollar":
            MessageLookupByLibrary.simpleMessage("Что такое Fuse Dollar?"),
        "what_is_peg": MessageLookupByLibrary.simpleMessage(
            "Как поддерживается привязка Fuse Dollar?"),
        "which_cryptocurrencies_can_i_use":
            MessageLookupByLibrary.simpleMessage(
                "Which cryptocurrencies can I use?"),
        "why_do_we_need_this":
            MessageLookupByLibrary.simpleMessage("Зачем нам это нужно?"),
        "will_never_share": MessageLookupByLibrary.simpleMessage(
            "Fuse никогда не будет передавать эту информацию третьим лицам."),
        "wire_transfer":
            MessageLookupByLibrary.simpleMessage("Банковский перевод"),
        "word": MessageLookupByLibrary.simpleMessage("Слово"),
        "word_not_match":
            MessageLookupByLibrary.simpleMessage("Слово не совпадает"),
        "would_you_like_to_approve_tx": MessageLookupByLibrary.simpleMessage(
            "Вы желаете одобрить транзакцию?"),
        "write_down_your_words":
            MessageLookupByLibrary.simpleMessage("Запишите свои 12 слов ..."),
        "write_word":
            MessageLookupByLibrary.simpleMessage("Пожалуйста, запиши слова"),
        "write_words": MessageLookupByLibrary.simpleMessage(
            "Запишите слова по порядку и сохраните. Без них вы не сможете восстановить свой аккаунт."),
        "wrong_phone_number":
            MessageLookupByLibrary.simpleMessage("Wrong phone number"),
        "wrong_phone_number_explained": MessageLookupByLibrary.simpleMessage(
            "This account is registered to another phone number. Please contact Support to update your phone number."),
        "yes": MessageLookupByLibrary.simpleMessage("Да"),
        "you_get": MessageLookupByLibrary.simpleMessage("Ты получишь"),
        "you_got_a": MessageLookupByLibrary.simpleMessage("Ты получил"),
        "you_got_a_new_NFT":
            MessageLookupByLibrary.simpleMessage("Вы получили новый NFT!"),
        "your_balance": MessageLookupByLibrary.simpleMessage("Твой баланс"),
        "your_balance_is": MessageLookupByLibrary.simpleMessage("Твой баланс"),
        "your_balance_is_empty":
            MessageLookupByLibrary.simpleMessage("Нужно пополнить баланс"),
        "your_coins": MessageLookupByLibrary.simpleMessage("Твои монеты"),
        "your_friends": MessageLookupByLibrary.simpleMessage(
            "Твои приглашённые друзья должны:"),
        "your_projected_balance":
            MessageLookupByLibrary.simpleMessage("Прогнозируемый баланс"),
        "your_wallet_is_empty":
            MessageLookupByLibrary.simpleMessage("Твой кошелек пуст!")
      };
}
