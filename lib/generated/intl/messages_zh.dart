// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
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
  String get localeName => 'zh';

  static String m0(amount) =>
      "Backup your wallet now and get ${amount} Fuse tokens!";

  static String m1(name) => "${name}，您好！";

  static String m2(name) => "向 ${name} 发送资金会自动邀请他们加入 Fuse 并让他们赎兑您发送的资金";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "Invite_a_friend": MessageLookupByLibrary.simpleMessage("推荐计划"),
        "Invite_a_friend_1":
            MessageLookupByLibrary.simpleMessage("向你的所有亲朋好友发送邀请！"),
        "Invite_a_friend_2": MessageLookupByLibrary.simpleMessage(
            "2. 通过信用卡/借记卡、电汇或以太坊/BSC 跨链桥为账户充任何金额"),
        "Invite_a_friend_3":
            MessageLookupByLibrary.simpleMessage("*不接受使用已经与 Fuse 账户关联的电话号码注册"),
        "Invite_a_friend_4":
            MessageLookupByLibrary.simpleMessage("**您可以获得奖励的最高存款金额等于 \$500"),
        "Invite_a_friend_5": MessageLookupByLibrary.simpleMessage(
            "***计划接受的资产：fUSD；USDC；USDT；WETH；WBTC；BNB"),
        "Invite_a_friend_6": MessageLookupByLibrary.simpleMessage(
            "3. 推荐奖励将以 Fuse 代币的形式提供，并且只适用于首次存钱"),
        "Invite_a_friend_button": MessageLookupByLibrary.simpleMessage("邀请"),
        "WC_connect_to_wallet":
            MessageLookupByLibrary.simpleMessage("想连接到您的钱包"),
        "WC_desc_one": MessageLookupByLibrary.simpleMessage("查看您的钱包余额和活动"),
        "WC_desc_two": MessageLookupByLibrary.simpleMessage("请求批准交易"),
        "about": MessageLookupByLibrary.simpleMessage("关于"),
        "account": MessageLookupByLibrary.simpleMessage("账户"),
        "action_bonus": MessageLookupByLibrary.simpleMessage("已接收"),
        "action_claimApy": MessageLookupByLibrary.simpleMessage("已领取"),
        "action_depositInitiated":
            MessageLookupByLibrary.simpleMessage("在 Ramp.network 待决"),
        "action_fiatDeposit": MessageLookupByLibrary.simpleMessage("已存入"),
        "action_receive": MessageLookupByLibrary.simpleMessage("已接收"),
        "action_send": MessageLookupByLibrary.simpleMessage("已发送"),
        "action_swap": MessageLookupByLibrary.simpleMessage("已交换"),
        "activate": MessageLookupByLibrary.simpleMessage("激活"),
        "activity": MessageLookupByLibrary.simpleMessage("活动"),
        "add_cash": MessageLookupByLibrary.simpleMessage("添加现金"),
        "address": MessageLookupByLibrary.simpleMessage("地址"),
        "address_on_fuse":
            MessageLookupByLibrary.simpleMessage("请确保您发送资金的目的地地址在 Fuse 网络上。"),
        "address_on_other": MessageLookupByLibrary.simpleMessage(
            "要在 Fuse 和其他网络（如 BSC 的以太坊）之间发送资金，请使用以下链接："),
        "amount": MessageLookupByLibrary.simpleMessage("金额"),
        "annual_yield": MessageLookupByLibrary.simpleMessage("50% 年收益！"),
        "approve": MessageLookupByLibrary.simpleMessage("批准"),
        "approved": MessageLookupByLibrary.simpleMessage("已批准"),
        "apy_explained_1": MessageLookupByLibrary.simpleMessage(
            "Fuse Dollar 赚取计划是一项储蓄计划，适合所有持有 fUSD (Fuse Dollar) 余额的用户"),
        "apy_explained_2": MessageLookupByLibrary.simpleMessage(
            "赚取计划允许任何 Fuse Cash 用户获得 DeFi 收益，而无需处理最低限额、费用或摩擦问题"),
        "apy_explained_3": MessageLookupByLibrary.simpleMessage(
            "没有锁仓，也不用等到年底，用户每周都有一次赎回收益的机会！"),
        "assets_and_contracts": MessageLookupByLibrary.simpleMessage("资产和合同"),
        "auth_failed_message": MessageLookupByLibrary.simpleMessage("请重试以继续"),
        "auth_failed_title": MessageLookupByLibrary.simpleMessage("认证失败"),
        "available": MessageLookupByLibrary.simpleMessage("可用的"),
        "back_up": MessageLookupByLibrary.simpleMessage("备份"),
        "back_up_now": MessageLookupByLibrary.simpleMessage("立即备份"),
        "backup_wallet": MessageLookupByLibrary.simpleMessage("备份"),
        "backup_wallet_now": m0,
        "balance": MessageLookupByLibrary.simpleMessage("余额"),
        "bonus": MessageLookupByLibrary.simpleMessage("奖励"),
        "bridge_from_BSC":
            MessageLookupByLibrary.simpleMessage("从币安智能链桥接 ETH 或 BNB"),
        "bridge_from_ethereum":
            MessageLookupByLibrary.simpleMessage("从以太坊网络桥接资产"),
        "bridge_to": MessageLookupByLibrary.simpleMessage("桥接至"),
        "buy": MessageLookupByLibrary.simpleMessage("买入"),
        "camera": MessageLookupByLibrary.simpleMessage("相机"),
        "cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "choose_lock_method":
            MessageLookupByLibrary.simpleMessage("请选择以下方法来保护您的钱包"),
        "claim": MessageLookupByLibrary.simpleMessage("立即领取！"),
        "close": MessageLookupByLibrary.simpleMessage("关闭"),
        "coins": MessageLookupByLibrary.simpleMessage("硬币"),
        "collectibles": MessageLookupByLibrary.simpleMessage("收藏品"),
        "coming_soon": MessageLookupByLibrary.simpleMessage("即将推出"),
        "community": MessageLookupByLibrary.simpleMessage("社区"),
        "community_address": MessageLookupByLibrary.simpleMessage("社区地址"),
        "community_webpage": MessageLookupByLibrary.simpleMessage("社区网页"),
        "confirmed": MessageLookupByLibrary.simpleMessage("已确认"),
        "congratulations": MessageLookupByLibrary.simpleMessage(
            "您已领取成功。赚取到的 Fuse Dollar 正在路上!"),
        "connect": MessageLookupByLibrary.simpleMessage("连接"),
        "connect_to_apps": MessageLookupByLibrary.simpleMessage("连接到应用程序"),
        "connection": MessageLookupByLibrary.simpleMessage("请修复您的互联网连接，然后重试！"),
        "contact_us": MessageLookupByLibrary.simpleMessage("Get help"),
        "contact_us_for_support":
            MessageLookupByLibrary.simpleMessage("Get help"),
        "continue_button": MessageLookupByLibrary.simpleMessage("继续"),
        "continue_with": MessageLookupByLibrary.simpleMessage("继续"),
        "contract_version":
            MessageLookupByLibrary.simpleMessage("Contract version"),
        "copied_to_clipboard": MessageLookupByLibrary.simpleMessage("已复制到剪贴板"),
        "copy_to_clipboard": MessageLookupByLibrary.simpleMessage("复制到剪贴板"),
        "create__wallet": MessageLookupByLibrary.simpleMessage("创建钱包"),
        "create_new_wallet": MessageLookupByLibrary.simpleMessage("创建一个新钱包"),
        "create_passcode": MessageLookupByLibrary.simpleMessage("创建您的密码"),
        "credit_card": MessageLookupByLibrary.simpleMessage("信用卡"),
        "crypto_deposit_bsc": MessageLookupByLibrary.simpleMessage(
            "如果你在币安智能链 (Binance Smart Chain, BSC) 有 ETH、BNB 或 FUSE，那么请使用下面的 URL，用 WalletConnect 连接你的钱包，然后桥接到 Fuse："),
        "crypto_deposit_eth": MessageLookupByLibrary.simpleMessage(
            "如果你在以太坊 (Ethereum) 有 USDC，那么请使用下面的 URL，用 WalletConnect 连接你的钱包，然后桥接到 Fuse："),
        "crypto_deposit_risk":
            MessageLookupByLibrary.simpleMessage("请注意，这是一条个人链接，可将资金直接连接到您的账户。"),
        "crypto_deposit_risk_2":
            MessageLookupByLibrary.simpleMessage("请负责任地使用它，并自行承担风险。"),
        "current_community": MessageLookupByLibrary.simpleMessage("当前社区"),
        "date_and_time": MessageLookupByLibrary.simpleMessage("日期和时间"),
        "deposit": MessageLookupByLibrary.simpleMessage("存入资金"),
        "deposit_and_receive_bonus":
            MessageLookupByLibrary.simpleMessage("向 Fuse 存钱，享 50% 年利率！"),
        "deposit_bonus_explained":
            MessageLookupByLibrary.simpleMessage("限时优惠。向 Fuse 存钱即可享 50% 年利率！"),
        "deposit_dollars": MessageLookupByLibrary.simpleMessage("存入美元"),
        "deposit_failed": MessageLookupByLibrary.simpleMessage("存入失败"),
        "deposit_from_BSC": MessageLookupByLibrary.simpleMessage("从 BSC 存入资金"),
        "deposit_from_ethereum":
            MessageLookupByLibrary.simpleMessage("从以太坊存入资金"),
        "deposit_from_ethereum_or_BSC":
            MessageLookupByLibrary.simpleMessage("从以太坊或 BSC 存入资金"),
        "deposit_fusd": MessageLookupByLibrary.simpleMessage("存入 Fuse Dollar"),
        "deposit_fuse_dollar":
            MessageLookupByLibrary.simpleMessage("存入 Fuse Dollar"),
        "deposit_your": MessageLookupByLibrary.simpleMessage("存入您的"),
        "deposit_your_first_dollars":
            MessageLookupByLibrary.simpleMessage("存入您的第一笔资金"),
        "didnt_get_message": MessageLookupByLibrary.simpleMessage("没收到消息？-"),
        "dismiss": MessageLookupByLibrary.simpleMessage("取消"),
        "dont_close_the_app": MessageLookupByLibrary.simpleMessage("请勿关闭应用"),
        "dont_show_next_time": MessageLookupByLibrary.simpleMessage("下次不再显示"),
        "dont_worry": MessageLookupByLibrary.simpleMessage("别担心："),
        "earn": MessageLookupByLibrary.simpleMessage("赚取"),
        "earn_apr": MessageLookupByLibrary.simpleMessage("赚取 50% 的年利率"),
        "earn_description": MessageLookupByLibrary.simpleMessage(
            "Fuse Dollars 的持有人只需在其余额中持有这些代币，就有资格获得每年 50% 的收益率。"),
        "earn_free_dollars": MessageLookupByLibrary.simpleMessage("赚取奖金 💸"),
        "earned_apy": MessageLookupByLibrary.simpleMessage("赚取的年化收益率"),
        "earned_so_far": MessageLookupByLibrary.simpleMessage("到目前为止赚了"),
        "earnings_received":
            MessageLookupByLibrary.simpleMessage("收到了 Fuse Dollar 收益！"),
        "edit": MessageLookupByLibrary.simpleMessage("编辑"),
        "enable_contacts_access":
            MessageLookupByLibrary.simpleMessage("启用联系人访问权限"),
        "enable_contacts_text":
            MessageLookupByLibrary.simpleMessage("启用同步联系人以便\n转账给您的手机联系人"),
        "enable_text": MessageLookupByLibrary.simpleMessage(
            "您的联系人将不会保存在我们的\n服务器上，此操作不会向他们\n发送任何消息"),
        "enter_community_address":
            MessageLookupByLibrary.simpleMessage("输入社区地址"),
        "enter_phone_number":
            MessageLookupByLibrary.simpleMessage("请输入您的电话号码，以便我们设置您的账户"),
        "enter_pincode": MessageLookupByLibrary.simpleMessage("输入您的 PIN 码："),
        "enter_verification_code":
            MessageLookupByLibrary.simpleMessage("\n请在此输入来自\n那条消息的 6 位数的验证码"),
        "error": MessageLookupByLibrary.simpleMessage("错误"),
        "face_id": MessageLookupByLibrary.simpleMessage("面容 ID"),
        "failed": MessageLookupByLibrary.simpleMessage("已失败"),
        "fee_amount": MessageLookupByLibrary.simpleMessage("费用金额："),
        "feed": MessageLookupByLibrary.simpleMessage("信息流"),
        "first_dollars": MessageLookupByLibrary.simpleMessage("第一笔资金"),
        "flash_off": MessageLookupByLibrary.simpleMessage("关闭 Flash"),
        "flash_on": MessageLookupByLibrary.simpleMessage("启用 Flash"),
        "follow_us_on_twitter":
            MessageLookupByLibrary.simpleMessage("在 Twitter 上关注我们。"),
        "for_more_info": MessageLookupByLibrary.simpleMessage("更多信息："),
        "for_text": MessageLookupByLibrary.simpleMessage("为"),
        "free": MessageLookupByLibrary.simpleMessage("免费"),
        "friend": MessageLookupByLibrary.simpleMessage("朋友"),
        "from": MessageLookupByLibrary.simpleMessage("从"),
        "fusd_stablecoins_explain": MessageLookupByLibrary.simpleMessage(
            "FuseDollar 是第一个 Fuse 原生稳定币。未来，我们计划添加与其他主要货币挂钩的稳定币，以加强使用，并减少世界各地用户的兼容冲突。敬请关注！"),
        "fuse_dollar": MessageLookupByLibrary.simpleMessage("Fuse Dollar"),
        "fuse_dollar_explain": MessageLookupByLibrary.simpleMessage(
            "FuseDollar (fUSD) 是一种在 Fuse Network 区块链上铸造的与美元挂钩的稳定币。它的创建是为了让加密货币和 DeFi 变得简单，让普通人也能使用。"),
        "fuse_network": MessageLookupByLibrary.simpleMessage("Fuse network"),
        "fuse_studio": MessageLookupByLibrary.simpleMessage(
            "您可以通过输入您的资产 ID（可从 Fuse Studio 获得）或扫描二维码切换到新社区"),
        "future_stablecoins": MessageLookupByLibrary.simpleMessage("未来的稳定币"),
        "gallery": MessageLookupByLibrary.simpleMessage("图库"),
        "generate_wallet_failed":
            MessageLookupByLibrary.simpleMessage("钱包生成失败"),
        "generated_wallet":
            MessageLookupByLibrary.simpleMessage("欢迎使用 Fuse 钱包"),
        "generating_wallet": MessageLookupByLibrary.simpleMessage("生成 Fuse 钱包"),
        "gift_a_friend": MessageLookupByLibrary.simpleMessage("Gift a friend"),
        "gift_a_friend_explained": MessageLookupByLibrary.simpleMessage(
            "Test the new invite feature and get 5\$ reward"),
        "greetTo": m1,
        "hi": MessageLookupByLibrary.simpleMessage("您好"),
        "home": MessageLookupByLibrary.simpleMessage("主页"),
        "how_much": MessageLookupByLibrary.simpleMessage("多少？"),
        "how_to_use_fusd":
            MessageLookupByLibrary.simpleMessage("如何使用 FuseDollar？"),
        "important": MessageLookupByLibrary.simpleMessage("重要内容！"),
        "important_update": MessageLookupByLibrary.simpleMessage("新版本！"),
        "initializing_wallet":
            MessageLookupByLibrary.simpleMessage("在 Fuse 上初始化您的钱包"),
        "insufficient_fund": MessageLookupByLibrary.simpleMessage("资金不足"),
        "intro_text_one":
            MessageLookupByLibrary.simpleMessage("支付和收取报酬或汇款给朋友，没有费用或不便之处"),
        "intro_text_three":
            MessageLookupByLibrary.simpleMessage("创建一个安全智能的代币账户，以访问去中心化金融"),
        "intro_text_two":
            MessageLookupByLibrary.simpleMessage("存入 \$ 并兑换成其他货币，几乎不收取任何费用"),
        "invalid_mnemonic":
            MessageLookupByLibrary.simpleMessage("Invalid mnemonic"),
        "invalid_number": MessageLookupByLibrary.simpleMessage("无效的号码"),
        "invalid_pincode": MessageLookupByLibrary.simpleMessage("PIN 码无效"),
        "invalid_qa_code": MessageLookupByLibrary.simpleMessage("无效的 QA 代码"),
        "invite_friend": MessageLookupByLibrary.simpleMessage("邀请朋友"),
        "invite_friend_text": MessageLookupByLibrary.simpleMessage(
            "使用 Fuse Cash 存钱，赚取高达 50% 年收益 💸"),
        "invite_text": m2,
        "join_bonus": MessageLookupByLibrary.simpleMessage("您获得了加入奖励！"),
        "join_earn_program": MessageLookupByLibrary.simpleMessage("加入赚取计划"),
        "join_our_referral_program":
            MessageLookupByLibrary.simpleMessage("Join our referral program"),
        "joined": MessageLookupByLibrary.simpleMessage("已加入"),
        "joined_community": MessageLookupByLibrary.simpleMessage(""),
        "joining": MessageLookupByLibrary.simpleMessage("加入"),
        "joining_community": MessageLookupByLibrary.simpleMessage("加入社区"),
        "language": MessageLookupByLibrary.simpleMessage("语言"),
        "learn_about_fuse_dollar":
            MessageLookupByLibrary.simpleMessage("了解 Fuse Dollar"),
        "learn_more": MessageLookupByLibrary.simpleMessage("了解更多"),
        "legal": MessageLookupByLibrary.simpleMessage("法律文件"),
        "lets_start": MessageLookupByLibrary.simpleMessage("就是这样！让我们开始吧"),
        "limit_discalimer":
            MessageLookupByLibrary.simpleMessage("（存款在 \$200 以上）"),
        "limit_offer": MessageLookupByLibrary.simpleMessage("限时优惠！\$50 存入赠金💸"),
        "limited_time_offer": MessageLookupByLibrary.simpleMessage("限时优惠"),
        "login": MessageLookupByLibrary.simpleMessage("登录"),
        "logout": MessageLookupByLibrary.simpleMessage("登出"),
        "map": MessageLookupByLibrary.simpleMessage("地图"),
        "max": MessageLookupByLibrary.simpleMessage("最高"),
        "min_to_claim": MessageLookupByLibrary.simpleMessage("最低领取金额：0.01 美元"),
        "move_to": MessageLookupByLibrary.simpleMessage("移至"),
        "my_communities": MessageLookupByLibrary.simpleMessage("我的社区"),
        "my_referrals": MessageLookupByLibrary.simpleMessage("我的推荐："),
        "name": MessageLookupByLibrary.simpleMessage("名称"),
        "network": MessageLookupByLibrary.simpleMessage("网络"),
        "network_fee": MessageLookupByLibrary.simpleMessage("网络费用"),
        "new_word": MessageLookupByLibrary.simpleMessage("New!"),
        "next_button": MessageLookupByLibrary.simpleMessage("下一步"),
        "next_claim": MessageLookupByLibrary.simpleMessage("下一次领取"),
        "next_claim_on": MessageLookupByLibrary.simpleMessage("下次领取时间："),
        "no": MessageLookupByLibrary.simpleMessage("否"),
        "no_activity": MessageLookupByLibrary.simpleMessage("没有活动"),
        "no_businesses": MessageLookupByLibrary.simpleMessage("未找到商家"),
        "no_funds_available": MessageLookupByLibrary.simpleMessage("没有可用资金"),
        "no_results_found":
            MessageLookupByLibrary.simpleMessage("No results found for"),
        "no_swap_option": MessageLookupByLibrary.simpleMessage("您还没有可交换的代币"),
        "not_connected":
            MessageLookupByLibrary.simpleMessage("No internet connection"),
        "not_enough_balance": MessageLookupByLibrary.simpleMessage("您的账户余额不足"),
        "offline": MessageLookupByLibrary.simpleMessage("您似乎已掉线"),
        "ok": MessageLookupByLibrary.simpleMessage("好的"),
        "ok_thanks": MessageLookupByLibrary.simpleMessage("好的，谢谢"),
        "oops": MessageLookupByLibrary.simpleMessage("哎呀"),
        "or": MessageLookupByLibrary.simpleMessage("或者"),
        "participation_explained": MessageLookupByLibrary.simpleMessage(
            "通过参与此计划，您的 Fuse Dollar 余额将自动获得 50% 的收益。"),
        "pay": MessageLookupByLibrary.simpleMessage("支付"),
        "pay_with": MessageLookupByLibrary.simpleMessage("支付方式："),
        "peg_explain": MessageLookupByLibrary.simpleMessage(
            "FuseDollar 受 Fuse 上的 USD Coin (USDC) 完全担保。USDC 由 circle.com 发行，是一种完全受美元支持、受监管的稳定币，在加密货币领域得到广泛认可。"),
        "pending": MessageLookupByLibrary.simpleMessage("待处理"),
        "phoneNumber": MessageLookupByLibrary.simpleMessage("电话号码"),
        "phrase_invaild":
            MessageLookupByLibrary.simpleMessage("12 个单词中有一个是无效的"),
        "pickup_display_name":
            MessageLookupByLibrary.simpleMessage("选择您要显示的名称"),
        "pickup_display_name_text":
            MessageLookupByLibrary.simpleMessage("此名称将对给您汇款的联系人显示，以便对方确认您的账户"),
        "pincode": MessageLookupByLibrary.simpleMessage("PIN 码"),
        "pincode_dont_match": MessageLookupByLibrary.simpleMessage("PIN 码不匹配"),
        "please_choose_security":
            MessageLookupByLibrary.simpleMessage("请选择您喜欢的方式用于钱包解锁："),
        "please_restore_your_wallet":
            MessageLookupByLibrary.simpleMessage("Please restore your wallet"),
        "please_use": MessageLookupByLibrary.simpleMessage("请使用"),
        "price": MessageLookupByLibrary.simpleMessage("价格"),
        "privacy": MessageLookupByLibrary.simpleMessage("Fuse.io/privacy"),
        "protect_wallet": MessageLookupByLibrary.simpleMessage("保护您的钱包"),
        "rate": MessageLookupByLibrary.simpleMessage("评分"),
        "rate_us": MessageLookupByLibrary.simpleMessage("在应用商店给我们评分"),
        "re_type_passcode": MessageLookupByLibrary.simpleMessage("重新输入您的密码"),
        "read_more": MessageLookupByLibrary.simpleMessage("阅读更多"),
        "receive": MessageLookupByLibrary.simpleMessage("接收"),
        "receive_from": MessageLookupByLibrary.simpleMessage("接收自"),
        "receive_gift": MessageLookupByLibrary.simpleMessage("接收礼物"),
        "received": MessageLookupByLibrary.simpleMessage("已接收"),
        "received_from_ethereum":
            MessageLookupByLibrary.simpleMessage("从以太坊接收"),
        "receiving": MessageLookupByLibrary.simpleMessage("接收"),
        "recent": MessageLookupByLibrary.simpleMessage("最近的"),
        "recommended": MessageLookupByLibrary.simpleMessage("推荐的"),
        "refer_your_friends": MessageLookupByLibrary.simpleMessage("推荐您的朋友"),
        "referral_bonus": MessageLookupByLibrary.simpleMessage("推荐奖励"),
        "referral_explained":
            MessageLookupByLibrary.simpleMessage("邀请朋友，可获得其存款 5% 的推荐奖励！"),
        "reject": MessageLookupByLibrary.simpleMessage("拒绝"),
        "resend_code": MessageLookupByLibrary.simpleMessage("重新发送验证码"),
        "reset_account":
            MessageLookupByLibrary.simpleMessage("创建新账户将重置您现有的账户 - 确定要继续吗？"),
        "restore": MessageLookupByLibrary.simpleMessage("Restore"),
        "restore_backup": MessageLookupByLibrary.simpleMessage("恢复备份"),
        "restore_from_backup": MessageLookupByLibrary.simpleMessage("从备份中恢复"),
        "restore_words":
            MessageLookupByLibrary.simpleMessage("这是您在创建上一个钱包时得到的 12 个词语"),
        "review_swap": MessageLookupByLibrary.simpleMessage("审查交换"),
        "review_trade": MessageLookupByLibrary.simpleMessage(""),
        "review_transfer": MessageLookupByLibrary.simpleMessage("审查转账"),
        "reward_for_deposits":
            MessageLookupByLibrary.simpleMessage("存款 200 美元或以上可获得 50 美元奖励"),
        "save_button": MessageLookupByLibrary.simpleMessage("保存"),
        "scan_address":
            MessageLookupByLibrary.simpleMessage("扫描 Fuse 地址二维码以汇款"),
        "scan_to_receive": MessageLookupByLibrary.simpleMessage("扫描二维码收款"),
        "scan_wallet_connect":
            MessageLookupByLibrary.simpleMessage("扫描 WalletConnect 二维码"),
        "search": MessageLookupByLibrary.simpleMessage("姓名或地址"),
        "selected": MessageLookupByLibrary.simpleMessage("已选"),
        "sell": MessageLookupByLibrary.simpleMessage("卖出"),
        "send": MessageLookupByLibrary.simpleMessage("发送"),
        "send_button": MessageLookupByLibrary.simpleMessage("发送"),
        "send_funds": MessageLookupByLibrary.simpleMessage("发送资金"),
        "send_to": MessageLookupByLibrary.simpleMessage("发送给"),
        "send_to_address": MessageLookupByLibrary.simpleMessage("发送到一个地址"),
        "send_to_your_vault":
            MessageLookupByLibrary.simpleMessage("Send to your vault"),
        "sending_on_fuse": MessageLookupByLibrary.simpleMessage(
            "Please make sure you are sending assets on the"),
        "sending_to_ethereum":
            MessageLookupByLibrary.simpleMessage("发送到您的以太坊钱包"),
        "sent": MessageLookupByLibrary.simpleMessage("已发送"),
        "sent_to": MessageLookupByLibrary.simpleMessage("发送给"),
        "sent_to_ethereum": MessageLookupByLibrary.simpleMessage("发送到以太坊"),
        "settings": MessageLookupByLibrary.simpleMessage("设置"),
        "share_button": MessageLookupByLibrary.simpleMessage("分享"),
        "sign_up": MessageLookupByLibrary.simpleMessage("注册"),
        "simple": MessageLookupByLibrary.simpleMessage("简单"),
        "skip_button": MessageLookupByLibrary.simpleMessage("跳过"),
        "slippage": MessageLookupByLibrary.simpleMessage("下跌"),
        "smart": MessageLookupByLibrary.simpleMessage("智能"),
        "social": MessageLookupByLibrary.simpleMessage("社交媒体"),
        "some_services_are_down": MessageLookupByLibrary.simpleMessage(
            "We\'re having issues with one of our services"),
        "something_went_wrong": MessageLookupByLibrary.simpleMessage("发生了一些错误"),
        "sqan_qr_code": MessageLookupByLibrary.simpleMessage("通过扫码来切换"),
        "start_earning": MessageLookupByLibrary.simpleMessage("开始赚取"),
        "stores_private": MessageLookupByLibrary.simpleMessage(
            "Fuse 钱包在设备本地存储私人信息。只有电话号码可以用来验证您的身份，并在向电话联系人汇款时减少不便之处。"),
        "success": MessageLookupByLibrary.simpleMessage("成功"),
        "support": MessageLookupByLibrary.simpleMessage("Support"),
        "swap": MessageLookupByLibrary.simpleMessage("交换"),
        "swapped": MessageLookupByLibrary.simpleMessage("已交换"),
        "swapping": MessageLookupByLibrary.simpleMessage("交换中"),
        "switch_community": MessageLookupByLibrary.simpleMessage("切换社区"),
        "sync_contacts": MessageLookupByLibrary.simpleMessage("同步通讯录"),
        "sync_your_contacts": MessageLookupByLibrary.simpleMessage("同步您的联系人"),
        "ten_seconds": MessageLookupByLibrary.simpleMessage("（最多 10 秒）"),
        "terms_conditions": MessageLookupByLibrary.simpleMessage("点击以展开条款和条件"),
        "thank_you": MessageLookupByLibrary.simpleMessage("谢谢您"),
        "thank_you_for_your_patience":
            MessageLookupByLibrary.simpleMessage("感谢您的耐心等待"),
        "thats_it": MessageLookupByLibrary.simpleMessage("就是这样"),
        "to": MessageLookupByLibrary.simpleMessage("至"),
        "to_protect": MessageLookupByLibrary.simpleMessage(
            "为了保护您的资金和钱包，现在进入设置并通过几个简单的步骤来备份您的钱包"),
        "to_unlock": MessageLookupByLibrary.simpleMessage("解锁！"),
        "token": MessageLookupByLibrary.simpleMessage("代币"),
        "top_up": MessageLookupByLibrary.simpleMessage("充值"),
        "top_up_your_account": MessageLookupByLibrary.simpleMessage("为您的账户充值"),
        "total_amount": MessageLookupByLibrary.simpleMessage("总金额："),
        "total_reward": MessageLookupByLibrary.simpleMessage("总奖励："),
        "touch_id": MessageLookupByLibrary.simpleMessage("触控 ID"),
        "trade": MessageLookupByLibrary.simpleMessage(""),
        "transaction_details": MessageLookupByLibrary.simpleMessage("交易明细"),
        "transaction_failed": MessageLookupByLibrary.simpleMessage("交易失败"),
        "transactions": MessageLookupByLibrary.simpleMessage("交易"),
        "try_again": MessageLookupByLibrary.simpleMessage("再试一次"),
        "txn": MessageLookupByLibrary.simpleMessage("交易"),
        "up_to_10": MessageLookupByLibrary.simpleMessage("（最多 10 秒）"),
        "update": MessageLookupByLibrary.simpleMessage("更新"),
        "update_process": MessageLookupByLibrary.simpleMessage("更新过程……"),
        "upgrade_wallet_text":
            MessageLookupByLibrary.simpleMessage("您需要更新钱包合约以启用新功能"),
        "upgrade_wallet_time":
            MessageLookupByLibrary.simpleMessage("单击“更新”即可完成，此过程大约需要 10 秒"),
        "use_fusd_explain": MessageLookupByLibrary.simpleMessage(
            "FuseDollar 可以在 FuseCash 上的账户之间以及 Fuse Cash 之外的 Fuse 账户之间自由流动。用户也可以使用 FuseSwap DEX 从 Fuse Cash 直接将 FuseDollar 换成其他加密货币，并且很快将可用于赚取被动收入。"),
        "use_max": MessageLookupByLibrary.simpleMessage("使用最大值"),
        "useful": MessageLookupByLibrary.simpleMessage("有用"),
        "version": MessageLookupByLibrary.simpleMessage("应用版本"),
        "visit_fuseio": MessageLookupByLibrary.simpleMessage(
            "访问 fuse.io 以了解有关 Fuse 及其后台工作原理的更多信息。"),
        "waiting_for_deposit":
            MessageLookupByLibrary.simpleMessage("等待您存入的资金到账"),
        "wallet": MessageLookupByLibrary.simpleMessage("钱包"),
        "wallet_address": MessageLookupByLibrary.simpleMessage("钱包地址"),
        "wallet_protected":
            MessageLookupByLibrary.simpleMessage("您的 Fuse 钱包已受到保护！"),
        "wallet_protected_text": MessageLookupByLibrary.simpleMessage(
            "太好了，您已经备份好了您的秘密词语。 请记得把您的秘密词语保存在安全可靠的地方，永远不要让任何人知道这些词语的用途。"),
        "want_to_earn_more":
            MessageLookupByLibrary.simpleMessage("Want to earn more?"),
        "we_just_sent": MessageLookupByLibrary.simpleMessage("我们刚发送了一条信息到"),
        "we_notice": MessageLookupByLibrary.simpleMessage("我们注意到您还没有备份您的钱包。"),
        "welcome_to_fuse":
            MessageLookupByLibrary.simpleMessage("欢迎来到 Fuse Cash！"),
        "welcome_to_fuse_text":
            MessageLookupByLibrary.simpleMessage("购买、交换、发送和赚取你的加密货币，无任何费用"),
        "welcome_to_wallet":
            MessageLookupByLibrary.simpleMessage("欢迎使用 fuse.cash 钱包"),
        "what_is_fuse_dollar":
            MessageLookupByLibrary.simpleMessage("什么是 FuseDollar？"),
        "what_is_peg":
            MessageLookupByLibrary.simpleMessage("FuseDollar 挂钩是如何维持的？"),
        "which_cryptocurrencies_can_i_use":
            MessageLookupByLibrary.simpleMessage(
                "Which cryptocurrencies can I use?"),
        "why_do_we_need_this":
            MessageLookupByLibrary.simpleMessage("为什么我们需要这个？"),
        "will_never_share":
            MessageLookupByLibrary.simpleMessage("Fuse 绝不会与第三方共享此信息。"),
        "wire_transfer": MessageLookupByLibrary.simpleMessage("电汇"),
        "word": MessageLookupByLibrary.simpleMessage("词语"),
        "word_not_match": MessageLookupByLibrary.simpleMessage("这个词语不匹配"),
        "would_you_like_to_approve_tx":
            MessageLookupByLibrary.simpleMessage("您想要批准这笔交易吗？"),
        "write_down_your_words":
            MessageLookupByLibrary.simpleMessage("写下您的 12 个词语……"),
        "write_word": MessageLookupByLibrary.simpleMessage("请写下这些词语"),
        "write_words": MessageLookupByLibrary.simpleMessage(
            "按顺序把词语写下来并妥善保管。没有它，您将无法恢复您的账户。"),
        "wrong_phone_number":
            MessageLookupByLibrary.simpleMessage("Wrong phone number"),
        "wrong_phone_number_explained": MessageLookupByLibrary.simpleMessage(
            "This account is registered to another phone number. Please contact Support to update your phone number."),
        "yes": MessageLookupByLibrary.simpleMessage("是"),
        "you_get": MessageLookupByLibrary.simpleMessage("您获得"),
        "you_got_a": MessageLookupByLibrary.simpleMessage("您获得了"),
        "you_got_a_new_NFT": MessageLookupByLibrary.simpleMessage("你获得了新 NFT！"),
        "your_balance": MessageLookupByLibrary.simpleMessage("您的余额"),
        "your_balance_is":
            MessageLookupByLibrary.simpleMessage("Your balance is"),
        "your_balance_is_empty": MessageLookupByLibrary.simpleMessage("您没有余额"),
        "your_coins": MessageLookupByLibrary.simpleMessage("您的硬币"),
        "your_friends": MessageLookupByLibrary.simpleMessage("您邀请的朋友必须："),
        "your_projected_balance":
            MessageLookupByLibrary.simpleMessage("您的预计余额"),
        "your_wallet_is_empty": MessageLookupByLibrary.simpleMessage("您的钱包是空的！")
      };
}
