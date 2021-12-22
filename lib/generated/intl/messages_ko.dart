// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko locale. All the
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
  String get localeName => 'ko';

  static String m0(amount) =>
      "Backup your wallet now and get ${amount} Fuse tokens!";

  static String m1(name) => "안녕하세요 ${name}";

  static String m2(name) =>
      "${name}님에게 돈을 보내면 자동으로 Fuse로 초대가 되어 전송된 자금을 받을 수 있게 됩니다";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "Invite_a_friend": MessageLookupByLibrary.simpleMessage("소개 프로그램"),
        "Invite_a_friend_1":
            MessageLookupByLibrary.simpleMessage("모든 친구와 가족에게 초대를 보내세요!"),
        "Invite_a_friend_2": MessageLookupByLibrary.simpleMessage(
            "2. 신용/직불 카드, 전신 송금, 또는 Ethereum/BSC 환전으로 계정에 원하는 만큼의 자금을 추가합니다"),
        "Invite_a_friend_3": MessageLookupByLibrary.simpleMessage(
            "*이미 Fuse 계정에 연결된 전화번호로는 회원가입하실 수 없습니다"),
        "Invite_a_friend_4": MessageLookupByLibrary.simpleMessage(
            "**보너스 수령에 산정될 수 있는 최대 예치 금액은 \$500입니다"),
        "Invite_a_friend_5": MessageLookupByLibrary.simpleMessage(
            "***다음 프로그램 내에서 자산이 인정됩니다: fUSD, USDC, USDT, WETH, WBTC, BNB"),
        "Invite_a_friend_6": MessageLookupByLibrary.simpleMessage(
            "3. 초대 보너스는 Fuse 토큰으로 제공되며, 첫 번째 예치에만 적용됩니다"),
        "Invite_a_friend_button": MessageLookupByLibrary.simpleMessage("초대"),
        "WC_connect_to_wallet":
            MessageLookupByLibrary.simpleMessage("당신의 지갑에 연결하시겠습니까"),
        "WC_desc_one": MessageLookupByLibrary.simpleMessage("지갑 잔액과 활동을 보기"),
        "WC_desc_two": MessageLookupByLibrary.simpleMessage("거래에 대한 승인을 요청"),
        "about": MessageLookupByLibrary.simpleMessage("소개"),
        "account": MessageLookupByLibrary.simpleMessage("계정"),
        "action_bonus": MessageLookupByLibrary.simpleMessage("수신됨"),
        "action_claimApy": MessageLookupByLibrary.simpleMessage("요청됨"),
        "action_depositInitiated":
            MessageLookupByLibrary.simpleMessage("Ramp.network에서 대기 중"),
        "action_fiatDeposit": MessageLookupByLibrary.simpleMessage("입금됨"),
        "action_receive": MessageLookupByLibrary.simpleMessage("수신됨"),
        "action_send": MessageLookupByLibrary.simpleMessage("전송됨"),
        "action_swap": MessageLookupByLibrary.simpleMessage("교환됨"),
        "activate": MessageLookupByLibrary.simpleMessage("활성화"),
        "activity": MessageLookupByLibrary.simpleMessage("활동"),
        "add_cash": MessageLookupByLibrary.simpleMessage("현금 추가"),
        "address": MessageLookupByLibrary.simpleMessage("주소"),
        "address_on_fuse": MessageLookupByLibrary.simpleMessage(
            "Please make sure the address you are sending funds to is on the Fuse Network."),
        "address_on_other": MessageLookupByLibrary.simpleMessage(
            "To send funds between Fuse and other networks like Ethereum of BSC please use the link below:"),
        "amount": MessageLookupByLibrary.simpleMessage("금액"),
        "annual_yield": MessageLookupByLibrary.simpleMessage("연간 수익의 50%!"),
        "approve": MessageLookupByLibrary.simpleMessage("승인"),
        "approved": MessageLookupByLibrary.simpleMessage("승인됨"),
        "apy_explained_1": MessageLookupByLibrary.simpleMessage(
            "Fuse 달러 수익 프로그램은 Fused 달러 잔액을 보유하고 있는 모든 사용자를 위한 저축 프로그램입니다.\n"),
        "apy_explained_2": MessageLookupByLibrary.simpleMessage(
            "수익 프로그램을 통해 Fuse Cash 사용자는 미니멈,수수료 또는 프릭션에 상관없이 DeFi 수익에 도달할 수 있습니다.\n"),
        "apy_explained_3": MessageLookupByLibrary.simpleMessage(
            "일주일에 한 번, 사용자는 연말까지 기다리지 않고 잠금 없이 수익을 벌충할 수 있습니다!\n"),
        "assets_and_contracts":
            MessageLookupByLibrary.simpleMessage("자산 및 연락처"),
        "auth_failed_message":
            MessageLookupByLibrary.simpleMessage("계속하려면 다시 시도하세요"),
        "auth_failed_title": MessageLookupByLibrary.simpleMessage("인증 실패"),
        "available": MessageLookupByLibrary.simpleMessage("이용 가능"),
        "back_up": MessageLookupByLibrary.simpleMessage("백업"),
        "back_up_now": MessageLookupByLibrary.simpleMessage("지금 백업"),
        "backup_wallet": MessageLookupByLibrary.simpleMessage("백업"),
        "backup_wallet_now": m0,
        "balance": MessageLookupByLibrary.simpleMessage("잔고"),
        "bonus": MessageLookupByLibrary.simpleMessage("보너스"),
        "bridge_from_BSC": MessageLookupByLibrary.simpleMessage(
            "Binance Smart Chain에서 ETH또는 BNB 연결"),
        "bridge_from_ethereum":
            MessageLookupByLibrary.simpleMessage("Ethereum 네트워크에서 자산 연결"),
        "bridge_to": MessageLookupByLibrary.simpleMessage("연결할 곳:"),
        "buy": MessageLookupByLibrary.simpleMessage("사기"),
        "camera": MessageLookupByLibrary.simpleMessage("카메라"),
        "cancel": MessageLookupByLibrary.simpleMessage("취소"),
        "choose_lock_method": MessageLookupByLibrary.simpleMessage(
            "다음 방식 중에서 골라 어떻게 지갑을 보호할지 선택하세요"),
        "claim": MessageLookupByLibrary.simpleMessage("지금 바로 청구하세요"),
        "close": MessageLookupByLibrary.simpleMessage("닫기"),
        "coins": MessageLookupByLibrary.simpleMessage("코인"),
        "collectibles": MessageLookupByLibrary.simpleMessage("수집 아이템"),
        "coming_soon": MessageLookupByLibrary.simpleMessage("곧 이용 가능"),
        "community": MessageLookupByLibrary.simpleMessage("커뮤니티"),
        "community_address": MessageLookupByLibrary.simpleMessage("커뮤니티 주소"),
        "community_webpage": MessageLookupByLibrary.simpleMessage("커뮤니티 웹 페이지"),
        "confirmed": MessageLookupByLibrary.simpleMessage("확인됨"),
        "congratulations": MessageLookupByLibrary.simpleMessage(
            "성공적으로 요청하셨습니다. 벌어들인 Fuse 달러가 오고 있습니다!"),
        "connect": MessageLookupByLibrary.simpleMessage("연결"),
        "connect_to_apps": MessageLookupByLibrary.simpleMessage("앱에 연결"),
        "connection":
            MessageLookupByLibrary.simpleMessage("인터넷 연결을 해결한 다음에 다시 시도하세요!"),
        "contact_us": MessageLookupByLibrary.simpleMessage("도움 알아보기"),
        "contact_us_for_support":
            MessageLookupByLibrary.simpleMessage("도움 알아보기"),
        "continue_button": MessageLookupByLibrary.simpleMessage("Continue"),
        "continue_with": MessageLookupByLibrary.simpleMessage("계속할 방식:"),
        "contract_version":
            MessageLookupByLibrary.simpleMessage("Contract version"),
        "copied_to_clipboard":
            MessageLookupByLibrary.simpleMessage("클립보드에 복사됨"),
        "copy_to_clipboard": MessageLookupByLibrary.simpleMessage("클립보드에 복사"),
        "create__wallet": MessageLookupByLibrary.simpleMessage("지갑 생성"),
        "create_new_wallet":
            MessageLookupByLibrary.simpleMessage("새 지갑을 생성하세요"),
        "create_passcode": MessageLookupByLibrary.simpleMessage("암호를 생성하세요"),
        "credit_card": MessageLookupByLibrary.simpleMessage("신용카드"),
        "crypto_deposit_bsc": MessageLookupByLibrary.simpleMessage(
            "Binance Smart Chain(BSC) 상에 ETH, BNB 또는 FUSE를 보유하고 계실 경우 아래의 URL을 이용하셔서, WalletConnect 및 브리지를 이용 중인 지갑을 Fuse에 연결하시기 바랍니다:"),
        "crypto_deposit_eth": MessageLookupByLibrary.simpleMessage(
            "Ethereum 상에 USDC를 보유하고 계실 경우 아래의 URL을 사용하셔서, WalletConnect 및 브리지를 이용 중인 지갑을 Fuse에 연결하시기 바랍니다:"),
        "crypto_deposit_risk": MessageLookupByLibrary.simpleMessage(
            "참고로 이 링크는 계정으로 자금을 곧장 연결해줄 개인 링크입니다."),
        "crypto_deposit_risk_2":
            MessageLookupByLibrary.simpleMessage("책임감 있게 위험을 각오하고 사용하시기 바랍니다."),
        "current_community": MessageLookupByLibrary.simpleMessage("현재 커뮤니티"),
        "date_and_time": MessageLookupByLibrary.simpleMessage("날짜 및 시간"),
        "deposit": MessageLookupByLibrary.simpleMessage("예치"),
        "deposit_and_receive_bonus": MessageLookupByLibrary.simpleMessage(
            "Fuse Dollar를 예치하시고 APR의 50%를 받으세요!"),
        "deposit_bonus_explained": MessageLookupByLibrary.simpleMessage(
            "한정 기간 이벤트. 귀하의 Fuse Dollar 예치에 대하여 APR의 50%를 받으세요!"),
        "deposit_dollars": MessageLookupByLibrary.simpleMessage("달러 예금"),
        "deposit_failed": MessageLookupByLibrary.simpleMessage("예치 실패"),
        "deposit_from_BSC": MessageLookupByLibrary.simpleMessage("BSC에서 예치"),
        "deposit_from_ethereum":
            MessageLookupByLibrary.simpleMessage("Ethereum에서 예치"),
        "deposit_from_ethereum_or_BSC":
            MessageLookupByLibrary.simpleMessage("Ethereum 또는 BSC에서 예치"),
        "deposit_fusd": MessageLookupByLibrary.simpleMessage("Fuse 달러 예금"),
        "deposit_fuse_dollar":
            MessageLookupByLibrary.simpleMessage("Fuse 달러 예금"),
        "deposit_your": MessageLookupByLibrary.simpleMessage("예치할 나의"),
        "deposit_your_first_dollars":
            MessageLookupByLibrary.simpleMessage("나의 첫 Dollars를 예치하세요"),
        "didnt_get_message":
            MessageLookupByLibrary.simpleMessage("메시지를 못 받으셨나요? -"),
        "dismiss": MessageLookupByLibrary.simpleMessage("해제"),
        "dont_close_the_app": MessageLookupByLibrary.simpleMessage("앱을 닫지 마세요"),
        "dont_show_next_time":
            MessageLookupByLibrary.simpleMessage("Don\'t show next time"),
        "dont_worry": MessageLookupByLibrary.simpleMessage("걱정하지 마세요."),
        "earn": MessageLookupByLibrary.simpleMessage("벌기"),
        "earn_apr": MessageLookupByLibrary.simpleMessage("연이율 50% 획득"),
        "earn_description": MessageLookupByLibrary.simpleMessage(
            "Fuse Dollars 소유자는 잔고에 해당 Dollars를 소지하고 있는 것만으로 일 년에 50%의 수익을 벌어들일 수 있습니다."),
        "earn_free_dollars":
            MessageLookupByLibrary.simpleMessage("공짜로 달러를 버세요 💸"),
        "earned_apy": MessageLookupByLibrary.simpleMessage("획득한 Apy"),
        "earned_so_far": MessageLookupByLibrary.simpleMessage("지금까지 번 금액"),
        "earnings_received":
            MessageLookupByLibrary.simpleMessage("Fuse 달러 수익을 받았습니다!"),
        "edit": MessageLookupByLibrary.simpleMessage("편집"),
        "enable_contacts_access":
            MessageLookupByLibrary.simpleMessage("연락처 액세스 활성화"),
        "enable_contacts_text": MessageLookupByLibrary.simpleMessage(
            "스마트폰 연락처로 돈을 보내려면 연락처 동기화를 활성화하세요"),
        "enable_text": MessageLookupByLibrary.simpleMessage(
            "연락처는 저희 서버에 저장되지 않으며 이 작업은 그들에게 어떤 메시지도 보내지 않습니다"),
        "enter_community_address":
            MessageLookupByLibrary.simpleMessage("커뮤니티 주소 입력"),
        "enter_phone_number": MessageLookupByLibrary.simpleMessage(
            "저희가 계정을 설정해드릴 수 있도록 전화번호를 입력해주세요"),
        "enter_pincode": MessageLookupByLibrary.simpleMessage("PIN 코드 입력:"),
        "enter_verification_code":
            MessageLookupByLibrary.simpleMessage("그 메시지에 있는 6자리 코드를 여기에 입력하세요"),
        "error": MessageLookupByLibrary.simpleMessage("오류"),
        "face_id": MessageLookupByLibrary.simpleMessage("Face ID"),
        "failed": MessageLookupByLibrary.simpleMessage("실패"),
        "fee_amount": MessageLookupByLibrary.simpleMessage("수수료:"),
        "feed": MessageLookupByLibrary.simpleMessage("피드"),
        "first_dollars": MessageLookupByLibrary.simpleMessage("첫 Dollars"),
        "flash_off": MessageLookupByLibrary.simpleMessage("플래시 끄기"),
        "flash_on": MessageLookupByLibrary.simpleMessage("플래시 켜기"),
        "follow_us_on_twitter":
            MessageLookupByLibrary.simpleMessage("Twitter에서 팔로우해주세요."),
        "for_more_info": MessageLookupByLibrary.simpleMessage("자세한 정보:"),
        "for_text": MessageLookupByLibrary.simpleMessage("대상:"),
        "free": MessageLookupByLibrary.simpleMessage("무료"),
        "friend": MessageLookupByLibrary.simpleMessage("친구"),
        "from": MessageLookupByLibrary.simpleMessage("보내는 곳:"),
        "fusd_stablecoins_explain": MessageLookupByLibrary.simpleMessage(
            "FuseDollar는 최초의 Fuse 전용 스테이블코인입니다. 앞으로는 전 세계의 사용자들이 더 많이 채택하고 프릭션을 줄일 수 있도록 다른 주요 통화에 페그된 스테이블코인을 추가할 계획입니다. 지켜봐주세요!"),
        "fuse_dollar": MessageLookupByLibrary.simpleMessage("Fuse Dollar"),
        "fuse_dollar_explain": MessageLookupByLibrary.simpleMessage(
            "FuseDollar(fUSD)는 Fuse Network 블록체인에서 주조되는 미국 달러에 페그된 스테이블코인입니다. 일반 사람들을 위해 암호화화폐와 DeFi를 단순하게 만들고자 제작되었습니다."),
        "fuse_network": MessageLookupByLibrary.simpleMessage("Fuse network"),
        "fuse_studio": MessageLookupByLibrary.simpleMessage(
            "Asset ID(Fuse Studio에서 이용 가능)를 입력하거나 QR 코드를 스캔하여 새 커뮤니티로 전환할 수 있습니다"),
        "future_stablecoins":
            MessageLookupByLibrary.simpleMessage("미래의 스테이블코인"),
        "gallery": MessageLookupByLibrary.simpleMessage("갤러리"),
        "generate_wallet_failed":
            MessageLookupByLibrary.simpleMessage("지갑 생성 실패"),
        "generated_wallet":
            MessageLookupByLibrary.simpleMessage("Fuse 지갑에 어서 오세요"),
        "generating_wallet":
            MessageLookupByLibrary.simpleMessage("Fuse 지갑 생성 중"),
        "gift_a_friend": MessageLookupByLibrary.simpleMessage("Gift a friend"),
        "gift_a_friend_explained": MessageLookupByLibrary.simpleMessage(
            "Test the new invite feature and get 5\$ reward"),
        "greetTo": m1,
        "hi": MessageLookupByLibrary.simpleMessage("안녕하세요"),
        "home": MessageLookupByLibrary.simpleMessage("홈"),
        "how_much": MessageLookupByLibrary.simpleMessage("얼마나 할까요?"),
        "how_to_use_fusd":
            MessageLookupByLibrary.simpleMessage("FuseDollar는 어떻게 쓰나요?"),
        "important": MessageLookupByLibrary.simpleMessage("중요!"),
        "important_update": MessageLookupByLibrary.simpleMessage("새로운 버전!"),
        "initializing_wallet":
            MessageLookupByLibrary.simpleMessage("나의 Fuse 지갑 초기화 중"),
        "insufficient_fund": MessageLookupByLibrary.simpleMessage("자금 불충분"),
        "intro_text_one": MessageLookupByLibrary.simpleMessage(
            "수수료나 프릭션 없이 친구에게 돈을 전송하거나 결제를 하고 결제를 받으세요"),
        "intro_text_three": MessageLookupByLibrary.simpleMessage(
            "안전하고 스마트한 토큰 계정을 생성해 디파이에 액세스하세요"),
        "intro_text_two": MessageLookupByLibrary.simpleMessage(
            "달러를 예치하고 거의 없다시피 한 수수료로 다른 통화로 전환하세요"),
        "invalid_mnemonic":
            MessageLookupByLibrary.simpleMessage("Invalid mnemonic"),
        "invalid_number": MessageLookupByLibrary.simpleMessage("유효하지 않은 번호"),
        "invalid_pincode":
            MessageLookupByLibrary.simpleMessage("유효하지 않은 PIN 코드"),
        "invalid_qa_code":
            MessageLookupByLibrary.simpleMessage("유효하지 않은 QA 코드"),
        "invite_friend": MessageLookupByLibrary.simpleMessage("친구를 초대하세요"),
        "invite_friend_text": MessageLookupByLibrary.simpleMessage(
            "귀하의 Fuse Cash 예치에 대하여 연간 수익의 최대 50%를 받으세요 💸"),
        "invite_text": m2,
        "join_bonus": MessageLookupByLibrary.simpleMessage("가입 보너스를 드립니다!"),
        "join_earn_program":
            MessageLookupByLibrary.simpleMessage("수익 프로그램에 가입하세요"),
        "join_our_referral_program":
            MessageLookupByLibrary.simpleMessage("Join our referral program"),
        "joined": MessageLookupByLibrary.simpleMessage("가입됨"),
        "joined_community": MessageLookupByLibrary.simpleMessage(""),
        "joining": MessageLookupByLibrary.simpleMessage("가입 중"),
        "joining_community": MessageLookupByLibrary.simpleMessage("커뮤니티 가입하기"),
        "language": MessageLookupByLibrary.simpleMessage("언어"),
        "learn_about_fuse_dollar":
            MessageLookupByLibrary.simpleMessage("Fuse Dollar 자세히 알아보기"),
        "learn_more": MessageLookupByLibrary.simpleMessage("자세히 알아보기"),
        "legal": MessageLookupByLibrary.simpleMessage("법률"),
        "lets_start": MessageLookupByLibrary.simpleMessage("됐습니다! 시작하죠"),
        "limit_discalimer":
            MessageLookupByLibrary.simpleMessage("(200달러 이상 예치용)"),
        "limit_offer":
            MessageLookupByLibrary.simpleMessage("한정된 시간 특가! 50달러 예치 보너스 💸"),
        "limited_time_offer": MessageLookupByLibrary.simpleMessage("기간 한정 이벤트"),
        "login": MessageLookupByLibrary.simpleMessage("로그인"),
        "logout": MessageLookupByLibrary.simpleMessage("로그아웃"),
        "map": MessageLookupByLibrary.simpleMessage("지도"),
        "max": MessageLookupByLibrary.simpleMessage("최대"),
        "min_to_claim":
            MessageLookupByLibrary.simpleMessage("청구할 최소 금액 - 0.01달러"),
        "move_to": MessageLookupByLibrary.simpleMessage("이동할 곳:"),
        "my_communities": MessageLookupByLibrary.simpleMessage("나의 커뮤니티"),
        "my_referrals": MessageLookupByLibrary.simpleMessage("내가 초대한 사람:"),
        "name": MessageLookupByLibrary.simpleMessage("이름"),
        "network": MessageLookupByLibrary.simpleMessage("네트워크"),
        "network_fee": MessageLookupByLibrary.simpleMessage("네트워크 수수료"),
        "new_word": MessageLookupByLibrary.simpleMessage("New!"),
        "next_button": MessageLookupByLibrary.simpleMessage("다음"),
        "next_claim": MessageLookupByLibrary.simpleMessage("다음 청구"),
        "next_claim_on": MessageLookupByLibrary.simpleMessage("에 대한 다음 청구"),
        "no": MessageLookupByLibrary.simpleMessage("아니요"),
        "no_activity": MessageLookupByLibrary.simpleMessage("활동 없음"),
        "no_businesses": MessageLookupByLibrary.simpleMessage("찾은 비즈니스 없음"),
        "no_funds_available":
            MessageLookupByLibrary.simpleMessage("이용 가능한 자금 없음"),
        "no_results_found":
            MessageLookupByLibrary.simpleMessage("No results found for"),
        "no_swap_option":
            MessageLookupByLibrary.simpleMessage("아직 전환할 토큰이 없습니다"),
        "not_connected":
            MessageLookupByLibrary.simpleMessage("No internet connection"),
        "not_enough_balance":
            MessageLookupByLibrary.simpleMessage("계정에 잔고가 충분하지 않습니다"),
        "offline": MessageLookupByLibrary.simpleMessage("오프라인 상태이신 것 같습니다"),
        "ok": MessageLookupByLibrary.simpleMessage("알겠습니다"),
        "ok_thanks": MessageLookupByLibrary.simpleMessage("네, 감사합니다"),
        "oops": MessageLookupByLibrary.simpleMessage("이런"),
        "or": MessageLookupByLibrary.simpleMessage("또는"),
        "participation_explained": MessageLookupByLibrary.simpleMessage(
            "프로그램에 참여하면 자동으로 Fuse 달러 잔액의 50%를 얻게 됩니다.\n"),
        "pay": MessageLookupByLibrary.simpleMessage("결제"),
        "pay_with": MessageLookupByLibrary.simpleMessage("결제 수단:"),
        "peg_explain": MessageLookupByLibrary.simpleMessage(
            "FuseDollar는 Fuse에서 USD 코인(USDC)을 담보로 완전하게 보증됩니다. circle.com에서 발행하는 USDC는 전적으로 달러를 기반으로 하여 통제되는, 암호화화폐계에서 널리 알려진 스테이블코인입니다."),
        "pending": MessageLookupByLibrary.simpleMessage("보류 중"),
        "phoneNumber": MessageLookupByLibrary.simpleMessage("전화번호"),
        "phrase_invaild": MessageLookupByLibrary.simpleMessage(
            "One of the 12 words is invalid"),
        "pickup_display_name":
            MessageLookupByLibrary.simpleMessage("표시 이름을 고르세요"),
        "pickup_display_name_text": MessageLookupByLibrary.simpleMessage(
            "내 계정을 식별할 수 있도록 돈을 보내오는 연락처에 이 이름이 표시됩니다"),
        "pincode": MessageLookupByLibrary.simpleMessage("PIN 코드"),
        "pincode_dont_match":
            MessageLookupByLibrary.simpleMessage("PIN 코드가 일치하지 않습니다"),
        "please_choose_security":
            MessageLookupByLibrary.simpleMessage("선호하는 지갑 해제 방식 선택:"),
        "please_restore_your_wallet":
            MessageLookupByLibrary.simpleMessage("Please restore your wallet"),
        "please_use": MessageLookupByLibrary.simpleMessage("이용 바람:"),
        "price": MessageLookupByLibrary.simpleMessage("가격"),
        "privacy": MessageLookupByLibrary.simpleMessage("Fuse.io/privacy"),
        "protect_wallet": MessageLookupByLibrary.simpleMessage("지갑을 보호하세요"),
        "rate": MessageLookupByLibrary.simpleMessage("평가"),
        "rate_us": MessageLookupByLibrary.simpleMessage("스토어에서 평가해주세요"),
        "re_type_passcode":
            MessageLookupByLibrary.simpleMessage("암호를 다시 입력하세요"),
        "read_more": MessageLookupByLibrary.simpleMessage("더 읽어보기"),
        "receive": MessageLookupByLibrary.simpleMessage("수령"),
        "receive_from": MessageLookupByLibrary.simpleMessage("보내오는 곳:"),
        "receive_gift": MessageLookupByLibrary.simpleMessage("선물 수령"),
        "received": MessageLookupByLibrary.simpleMessage("수신됨"),
        "received_from_ethereum":
            MessageLookupByLibrary.simpleMessage("Ethereum에서 수령됨"),
        "receiving": MessageLookupByLibrary.simpleMessage("받는 중"),
        "recent": MessageLookupByLibrary.simpleMessage("최근"),
        "recommended": MessageLookupByLibrary.simpleMessage("추천됨"),
        "refer_your_friends": MessageLookupByLibrary.simpleMessage("친구를 초대하세요"),
        "referral_bonus": MessageLookupByLibrary.simpleMessage("위탁 보너스"),
        "referral_explained": MessageLookupByLibrary.simpleMessage(
            "친구를 초대하고 예치금의 5%를 초대 보너스로 받으세요!"),
        "reject": MessageLookupByLibrary.simpleMessage("거절"),
        "resend_code": MessageLookupByLibrary.simpleMessage("코드 재전송"),
        "reset_account": MessageLookupByLibrary.simpleMessage(
            "새 계정을 생성하면 기존 계정이 초기화됩니다. 정말로 계속하시겠습니까?"),
        "restore": MessageLookupByLibrary.simpleMessage("Restore"),
        "restore_backup": MessageLookupByLibrary.simpleMessage("백업 복구"),
        "restore_from_backup": MessageLookupByLibrary.simpleMessage("백업에서 복구"),
        "restore_words":
            MessageLookupByLibrary.simpleMessage("이전 지갑을 생성할 때 드린 단어 12개입니다."),
        "review_swap": MessageLookupByLibrary.simpleMessage("전환 검토"),
        "review_trade": MessageLookupByLibrary.simpleMessage(""),
        "review_transfer": MessageLookupByLibrary.simpleMessage("거래 검토"),
        "reward_for_deposits": MessageLookupByLibrary.simpleMessage(
            "200달러 이상의 보증금에 대한 50달러 보상금 수령"),
        "save_button": MessageLookupByLibrary.simpleMessage("저장"),
        "scan_address": MessageLookupByLibrary.simpleMessage(
            "돈을 보내려면 Fuse 주소 QR 코드를 스캔하세요"),
        "scan_to_receive":
            MessageLookupByLibrary.simpleMessage("돈을 수령하려면 QR 코드를 스캔하세요"),
        "scan_wallet_connect":
            MessageLookupByLibrary.simpleMessage("WalletConnect QR 코드 스캔"),
        "search": MessageLookupByLibrary.simpleMessage("이름 또는 주소"),
        "selected": MessageLookupByLibrary.simpleMessage("선택됨"),
        "sell": MessageLookupByLibrary.simpleMessage("팔기"),
        "send": MessageLookupByLibrary.simpleMessage("전송"),
        "send_button": MessageLookupByLibrary.simpleMessage("전송"),
        "send_funds": MessageLookupByLibrary.simpleMessage("자금 보내기"),
        "send_to": MessageLookupByLibrary.simpleMessage("전송할 곳:"),
        "send_to_address": MessageLookupByLibrary.simpleMessage("주소로 전송"),
        "send_to_your_vault":
            MessageLookupByLibrary.simpleMessage("Send to your vault"),
        "sending_on_fuse": MessageLookupByLibrary.simpleMessage(
            "Please make sure you are sending assets on the"),
        "sending_to_ethereum":
            MessageLookupByLibrary.simpleMessage("나의 Ethereum 지갑으로 전송됨"),
        "sent": MessageLookupByLibrary.simpleMessage("발신됨"),
        "sent_to": MessageLookupByLibrary.simpleMessage("보낼 곳:"),
        "sent_to_ethereum":
            MessageLookupByLibrary.simpleMessage("Ethereum으로 전송됨"),
        "settings": MessageLookupByLibrary.simpleMessage("설정"),
        "share_button": MessageLookupByLibrary.simpleMessage("공유"),
        "sign_up": MessageLookupByLibrary.simpleMessage("회원 가입"),
        "simple": MessageLookupByLibrary.simpleMessage("간편"),
        "skip_button": MessageLookupByLibrary.simpleMessage("건너뛰기"),
        "slippage": MessageLookupByLibrary.simpleMessage("슬리피지"),
        "smart": MessageLookupByLibrary.simpleMessage("스마트"),
        "social": MessageLookupByLibrary.simpleMessage("소셜"),
        "some_services_are_down": MessageLookupByLibrary.simpleMessage(
            "We\'re having issues with one of our services"),
        "something_went_wrong":
            MessageLookupByLibrary.simpleMessage("오류가 발생했습니다"),
        "sqan_qr_code": MessageLookupByLibrary.simpleMessage("QR 코드를 스캔해 전환"),
        "start_earning": MessageLookupByLibrary.simpleMessage("수익 창출 시작"),
        "stores_private": MessageLookupByLibrary.simpleMessage(
            "Fuse 지갑은 로컬 장치에 개인 정보를 보관합니다. 전화번호만 사용해서 본인을 인증할 수 있어 연락처로 돈을 보낼 때 프릭션을 줄일 수 있습니다."),
        "success": MessageLookupByLibrary.simpleMessage("성공"),
        "support": MessageLookupByLibrary.simpleMessage("Support"),
        "swap": MessageLookupByLibrary.simpleMessage("전환"),
        "swapped": MessageLookupByLibrary.simpleMessage("전환됨"),
        "swapping": MessageLookupByLibrary.simpleMessage("전환 중"),
        "switch_community": MessageLookupByLibrary.simpleMessage("커뮤니티 전환"),
        "sync_contacts": MessageLookupByLibrary.simpleMessage("연락처 동기화"),
        "sync_your_contacts":
            MessageLookupByLibrary.simpleMessage("연락처를 동기화하세요"),
        "ten_seconds": MessageLookupByLibrary.simpleMessage("(최대 10초)"),
        "terms_conditions":
            MessageLookupByLibrary.simpleMessage("클릭해서 약관 및 조건 늘려보기"),
        "thank_you": MessageLookupByLibrary.simpleMessage("감사합니다"),
        "thank_you_for_your_patience":
            MessageLookupByLibrary.simpleMessage("기다려주셔서 감사합니다"),
        "thats_it": MessageLookupByLibrary.simpleMessage("바로 그겁니다"),
        "to": MessageLookupByLibrary.simpleMessage("받는 곳:"),
        "to_protect": MessageLookupByLibrary.simpleMessage(
            "돈과 지갑 보호를 위해 지금 설정으로 이동한 다음 간단한 몇 가지 절차를 거쳐 지갑을 백업하세요"),
        "to_unlock": MessageLookupByLibrary.simpleMessage("해제하기!"),
        "token": MessageLookupByLibrary.simpleMessage("토큰"),
        "top_up": MessageLookupByLibrary.simpleMessage("탑업"),
        "top_up_your_account":
            MessageLookupByLibrary.simpleMessage("계정을 탑업하세요"),
        "total_amount": MessageLookupByLibrary.simpleMessage("총액:"),
        "total_reward": MessageLookupByLibrary.simpleMessage("총 리워드:"),
        "touch_id": MessageLookupByLibrary.simpleMessage("Touch ID"),
        "trade": MessageLookupByLibrary.simpleMessage(""),
        "transaction_details": MessageLookupByLibrary.simpleMessage("거래 상세 정보"),
        "transaction_failed": MessageLookupByLibrary.simpleMessage("거래 실패"),
        "transactions": MessageLookupByLibrary.simpleMessage("거래"),
        "try_again": MessageLookupByLibrary.simpleMessage("다시 시도"),
        "txn": MessageLookupByLibrary.simpleMessage("거래"),
        "up_to_10": MessageLookupByLibrary.simpleMessage("(최대 10초)"),
        "update": MessageLookupByLibrary.simpleMessage("업데이트"),
        "update_process": MessageLookupByLibrary.simpleMessage("업데이트 진행중..."),
        "upgrade_wallet_text": MessageLookupByLibrary.simpleMessage(
            "새 기능을 사용하려면 지갑 계약을 업데이트해야 합니다.\n"),
        "upgrade_wallet_time": MessageLookupByLibrary.simpleMessage(
            "\"update\"를 클릭하여 완료하는 데 약 10초가 걸립니다.\n"),
        "use_fusd_explain": MessageLookupByLibrary.simpleMessage(
            "FuseDollars는 FuseCash 계정간 이동하는 것뿐 아니라 Fuse Cash 외의 Fuse 계정으로 이동하는 것도 자유롭습니다. FuseSwap DEX를 이용하여 Fuse Cash에서 바로 타 암호화화폐로 전환할 수도 있으며, 패시브인컴을 벌어들일 수 있도록 곧 사용이 가능해집니다."),
        "use_max": MessageLookupByLibrary.simpleMessage("최대치 사용"),
        "useful": MessageLookupByLibrary.simpleMessage("유용"),
        "version": MessageLookupByLibrary.simpleMessage("앱 버전"),
        "visit_fuseio": MessageLookupByLibrary.simpleMessage(
            "fuse.io를 방문하시면 Fuse가 어떤 곳이고 배후에서 어떤 식으로 일을 처리하는지 자세히 알아보실 수 있습니다."),
        "waiting_for_deposit":
            MessageLookupByLibrary.simpleMessage("예치금이 도착하기를 기다리는 중"),
        "wallet": MessageLookupByLibrary.simpleMessage("지갑"),
        "wallet_address": MessageLookupByLibrary.simpleMessage("지갑 주소"),
        "wallet_protected":
            MessageLookupByLibrary.simpleMessage("Fuse 지갑이 보호되고 있습니다!"),
        "wallet_protected_text": MessageLookupByLibrary.simpleMessage(
            "훌륭합니다. 비밀 문구를 백업하셨습니다. 비밀 문구는 안전하고 든든한 곳에 보관하며 누구에게도 알려주지 마세요."),
        "want_to_earn_more": MessageLookupByLibrary.simpleMessage("더 얻고 싶으세요?"),
        "we_just_sent": MessageLookupByLibrary.simpleMessage("방금 메시지를 보내드린 곳:"),
        "we_notice":
            MessageLookupByLibrary.simpleMessage("아직 지갑을 백업하지 않으셨습니다."),
        "welcome_to_fuse":
            MessageLookupByLibrary.simpleMessage("Fuse 지갑에 오신 것을 환영합니다!"),
        "welcome_to_fuse_text": MessageLookupByLibrary.simpleMessage(
            "수수료 없는 가상 화폐의 구매, 교환, 전송 및 수익 실현"),
        "welcome_to_wallet":
            MessageLookupByLibrary.simpleMessage("fuse 현금 지갑에 오신 걸 환영합니다"),
        "what_is_fuse_dollar":
            MessageLookupByLibrary.simpleMessage("FuseDollar가 뭔가요?"),
        "what_is_peg":
            MessageLookupByLibrary.simpleMessage("FuseDollar 페그는 어떻게 관리되나요?"),
        "which_cryptocurrencies_can_i_use":
            MessageLookupByLibrary.simpleMessage(
                "Which cryptocurrencies can I use?"),
        "why_do_we_need_this":
            MessageLookupByLibrary.simpleMessage("저희에게 이것이 왜 필요할까요?"),
        "will_never_share": MessageLookupByLibrary.simpleMessage(
            "Fuse는 이 정보를 제삼자와 절대로 공유하지 않습니다."),
        "wire_transfer": MessageLookupByLibrary.simpleMessage("계좌이체"),
        "word": MessageLookupByLibrary.simpleMessage("단어"),
        "word_not_match": MessageLookupByLibrary.simpleMessage("단어가 일치하지 않습니다"),
        "would_you_like_to_approve_tx":
            MessageLookupByLibrary.simpleMessage("거래를 승인하시겠습니까?"),
        "write_down_your_words":
            MessageLookupByLibrary.simpleMessage("본인의 단어 12개를 적어주세요..."),
        "write_word": MessageLookupByLibrary.simpleMessage("단어를 적어주세요"),
        "write_words": MessageLookupByLibrary.simpleMessage(
            "단어를 순서대로 적어 안전을 유지하세요. 단어가 없이는 계정을 복구할 수 없습니다."),
        "wrong_phone_number":
            MessageLookupByLibrary.simpleMessage("Wrong phone number"),
        "wrong_phone_number_explained": MessageLookupByLibrary.simpleMessage(
            "This account is registered to another phone number. Please contact Support to update your phone number."),
        "yes": MessageLookupByLibrary.simpleMessage("네"),
        "you_get": MessageLookupByLibrary.simpleMessage("수령하세요"),
        "you_got_a": MessageLookupByLibrary.simpleMessage("받은 것:"),
        "you_got_a_new_NFT":
            MessageLookupByLibrary.simpleMessage("새 NFT를 받으셨습니다!"),
        "your_balance": MessageLookupByLibrary.simpleMessage("나의 잔고"),
        "your_balance_is": MessageLookupByLibrary.simpleMessage("당신의 계좌는"),
        "your_balance_is_empty":
            MessageLookupByLibrary.simpleMessage("잔고가 없습니다"),
        "your_coins": MessageLookupByLibrary.simpleMessage("당신의 코인"),
        "your_friends":
            MessageLookupByLibrary.simpleMessage("초대받은 친구는 다음 조건에 부합해야 합니다:"),
        "your_projected_balance": MessageLookupByLibrary.simpleMessage("예상 잔액"),
        "your_wallet_is_empty":
            MessageLookupByLibrary.simpleMessage("지갑이 비었습니다!")
      };
}
