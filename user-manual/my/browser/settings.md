# CENO ဆက်တင်များ

CENO Browser allows you to change some Ouinet-specific settings and get
information about your client in a simple manner. This should not be needed for
normal operation, but it would be helpful for testing different strategies
against network interference, as well as reporting issues with the app.

> **Technical note:** These options are provided by the *CENO Extension*, a
Firefox extension which comes installed out of the box with CENO and takes care
of proper integration with Ouinet, like enabling content injection and cache
retrieval under public browsing, hinting the user about the source of the
content being visualized, and notifying about new versions of Ouinet.

> These features are available on a page that can be accessed by choosing *CENO*
in the app's main menu. Please note that the menu entry may take a few seconds
to pop up on app start. The page should look like this:

> **![ စာမျက်နှာ](images/settings.png)

> ## ဝင်ရောက်သုံးစွဲမှု စက်ကိရိယာကို ရွေးချယ်ခြင်း
>
> The four checkboxes on the top of the page selectively enable or disable the
different mechanisms or *sources* that CENO as a Ouinet client uses to retrieve
content while using either [public or private browsing](public-private.md) tabs.
All boxes are enabled by default.

> - *ဝက်ဘ်ဆိုက်မှ တိုက်ရိုက်* (သို့မဟုတ် **မူလ ဝင်ရောက်သုံးစွဲမှု**) သည် အောက်တွင်
ဖွင့်ထားသော အခြားစက်ကိရိယာများကို မကြိုးစားခင် CENO အား မူလဆာဗာထံ
တိုက်ရိုက်ရောက်အောင် ကြိုးစားခွင့်ပြုသည်။
ဤစက်ကိရိယာသည် သီးသန့်နှင့် အများသုံး ရှာဖွေခြင်းမုဒ် နှစ်ခုလုံးအတွက်
အလုပ်လုပ်သည့်တိုင်အောင် ထိုသို့ ပြန်ထုတ်ထားသော အကြောင်းအရာကို အခြားသူများနှင့်
မမျှဝေနိုင်ပါ။
If getting most Web content is not particularly slow or expensive, this
mechanism may be more than enough for most use cases. However, such direct
connections may be tracked by your ISP or government. To some extent, disabling
this option may avoid such connections and trivial tracking (but not completely,
see [risks](../concepts/risks.md)).
Also, when accessing a Web site over insecure HTTP (instead of the more secure
HTTPS), a censor may intercept the connection and supply the user with a bogus
site, a tampering which CENO cannot detect by itself. In such cases, it may help
to disable this option and thus always resort to other, safer CENO mechanisms.

> - *CENO ကွန်ရက် (သီးသန့်) မှတစ်ဆင့်* (သို့မဟုတ် **ပရောက်စီ ဝင်ရောက်သုံးစွဲခွင့်**)
သည် မူလ ဆာဗာများသို့ ရောက်ရှိရန် CENO အား ထိုးသွင်းဖိုင်များကို ပုံမှန် HTTP
ပရောက်စီ ဆာဗာများအဖြစ် အသုံးပြုခွင့်ပေးသည်။
ဤစက်ကိရိယာသည် သီးသန့် ရှာဖွေမှုမုဒ်တွင်သာ အလုပ်လုပ်သည်။
When accessing content over HTTPS, only origin servers will be able to decrypt
traffic. When using plain HTTP, the injector may also see the unencrypted
traffic (but it should still not sign or share its content with others). Other
participants, such as bridges, will never see the unencrypted traffic.

> - *Via the CENO network (public)* (or **injector access**) enables CENO to strip
any private information from requests and send them to an injector. The injector
gets the content from an origin server, signs it, and sends it back to CENO -
which then begins seeding it.
Other participants (such as bridges) will not see the unencrypted traffic.
ဤစက်ကိရိယာသည် သီးသန့် ရှာဖွေမှုမုဒ်တွင်သာ အလုပ်လုပ်သည်။

> - *အခြား CENO သုံးစွဲသူများက မျှဝေထားသည်* သည် CENO အား အကြောင်းအရာကို
**ဖြန့်ချိထားသော ယာယီသိမ်းဆည်းထားသည့် မှတ်ဉာဏ်** မှ ပြန်ထုတ်ရန်
ကြိုးစားခွင့်ပြုသည်။ ဆိုလိုသည်မှာ ၎င်းကို တင်ပို့သော အခြား CENO နှင့် Ouinet
လက်ခံစက်များထံမှ ဖြစ်သည်။
ဤစက်ကိရိယာသည် သီးသန့် ရှာဖွေမှုမုဒ်တွင်သာ အလုပ်လုပ်သည်။

>
> Disabling all of the mechanisms available for either public or private browsing
mode will render them useless. If you establish such a configuration, a warning
will be shown as depicted below:

> ![ပုံ- သီးသန့် ရှာဖွေမှုအတွက် မမှန်ကန်သော ဆက်တင်များ](images/settings-no-
private.png)

> **Warning:** Please note that CENO does not remember these settings upon
restarting the app. If you require some of the previous mechanisms to be off
while using CENO, please remember to open the Settings page whenever you start
the app and uncheck their boxes before browsing. We apologize for the
inconvenience.

> ## သင်၏ အက်ပ်အကြောင်း
>
> This page also provides you with some information about your CENO Browser app
and Ouinet client:

> - *CENO ဘရောက်ဇာ* သည် သင်အသုံးပြုနေသော CENO ဗားရှင်း အတိအကျကို ညွှန်ပြသည်။
ကျေးဇူးပြု၍ ဤအချက်အလက်ကို သင်၏ ပြဿနာ အစီရင်ခံစာများတွင် ထည့်ပါ။
> - *CENO အဆက်* သည် Firefox ကို CENO နှင့် ပေါင်းစည်းပေးသော အဆက်၏ ဗားရှင်းကို
ပြသသည်။ အစီရင်ခံစာများတွင်လည်း ထည့်ပါ။
> - *Ouinet* သည် CENO ကို ထောက်ခံသော Ouinet ၏ ဗားရှင်းကို ပြသသည်။
အစီရင်ခံစာများတွင်လည်း ထည့်ပါ။
> - *Ouinet ပရိုတိုကော* သည် CENO က အခြား Ouinet လက်ခံစက်များနှင့်
ထိုးသွင်းဖိုင်များနှင့် ဆက်သွယ်ရန် အသုံးပြုသော ပရိုတိုကော၏ ဗားရှင်းနံပါတ်
ဖြစ်သည်။ အစီရင်ခံစာများတွင်လည်း ထည့်ပါ။
> - *စက်တွင်း UDP အဆုံးမှတ်(များ)* သည် CENO က အခြားလက်ခံစက်များထံ လက်မှတ်ထိုးထားသော
အကြောင်းအရာကို တင်ပို့ရန် အသုံးပြုသော အင်တာနက် လိပ်စာများ ဖြစ်သည်။ အက်ပ်ကို
ကူညီစမ်းသပ်ရန်နှင့် ချွတ်ယွင်းချက် ပြုပြင်ရန်အတွက် ၎င်းတို့ကို ပြသထားပြီး
ယေဘုယျအားဖြင့် မထုတ်ဖော်သင့်ပါ။
> - *UPnP အခြေအနေ* သည် CENO က သင့်ရောက်တာ သို့မဟုတ် ဝင်ရောက်သုံးစွဲမှု ပွိုင့်အား
၎င်းထံလာသည့် အဝင်ချိတ်ဆက်မှုများကို ခွင့်ပြုရန် ပြောနိုင်ခဲ့ခြင်း ရှိ၊ မရှိကို
ညွှန်ပြသည်။ အစီရင်ခံစာများတွင်လည်း ထည့်ပါ။
> - *ရောက်ရှိနိုင်မှု အခြေအနေ* သည် သင့်စက်က အခြားလက်ခံစက်များထံ အကြောင်းအရာကို
ထိရောက်စွာ တင်ပို့ရန် မည်မျှဖြစ်နိုင်ခြေရှိကြောင်း ညွှန်ပြသည်။
အစီရင်ခံစာများတွင်လည်း ထည့်ပါ။
> - *စက်တွင်း ယာယီသိမ်းဆည်းထားသော မှတ်ဉာဏ် အရွယ်အစား* သည် သင့်စက်၏ စက်တွင်း
ယာယီသိမ်းဆည်းထားသော မှတ်ဉာဏ်မှ တင်ပို့နေသော အကြောင်းအရာက သိုလှောင်မှုမည်မျှကို
နေရာယူကြောင်း မှန်းခြေကို ပြသသည်။
>
> ## စက်တွင်း ယာယီသိမ်းဆည်းထားသော မှတ်ဉာဏ်ကို ထုတ်ပယ်ခြင်း
>
> Next to the *Local cache size* value above, there is a button which allows you
to stop seeding and drop all content shared by your device over Ouinet. This
allows you to free up some storage space in your device while keeping other CENO
settings like Favorites.

> If you want to clear CENO's normal browsing cache (the one used by the browser
but not shared with others) or other items like cookies, browsing history or
favorites, you should choose *Settings* in the app's main menu, then *Clear
private data*. You will be asked about which items you want to clear.

> To drop everything at the same time (especially if you are in a hurry), please
learn how to use the "panic button" feature described in [Installing
CENO](install.md).

> ## စာရင်း မက်ဆေ့ချ်များကို စုဆောင်းခြင်း
>
> စာမျက်နှာ၏ အောက်ခြေတွင် သင့်အား Ouinet ၏ စက်တွင်း မက်ဆေ့ချ်အားလုံးကို
စုဆောင်းပြီး ၎င်းတို့ကို ဖိုင်တစ်ခုထဲသို့ ဒေါင်းလုဒ်လုပ်ခွင့်ပြုသည့်
*စာရင်းဖိုင် ဖွင့်မည်* အကွက်တစ်ခု ရှိသည်။ ယင်းကို CENO တွင် ပြဿနာတစ်ခုခုကို
အမျိုးအမည်သတ်မှတ်သည့် အချိန်တွင်သာ အသုံးပြုသင့်သည်။ အောက်ပါ အဆင့်များကိုသာ
လိုက်နာပါ-

> 1. *CENO ဆက်တင်များ* စာမျက်နှာတွင် *စာရင်းဖိုင် ဖွင့်မည်* ကို အမှန်ခြစ်ပါ။
> 2. ရှာဖွေမှုသို့ ပြန်သွားပြီး ပြဿနာဖြစ်စေသော အပြုအမူကို လှုံ့ဆော်သည့်
မည်သည့်လုပ်ဆောင်ချက်များကိုမဆို ပြုလုပ်ပါ။
> 3. *CENO ဆက်တင်များ* စာမျက်နှာသို့ ပြန်သွားပြီး *စာရင်းဖိုင်ဖွင့်မည်* အကွက်ဘေးရှိ
*ဒေါင်းလုဒ်လုပ်ရန်* လင့်ကို နှိပ်ပါ။ နောက်ပိုင်းတွင် အသုံးပြုရန်အတွက် ဖိုင်ကို
သိမ်းဆည်းပါ။ ဤနေရာတွင် Android သည် သိုလှောင်ထားသော မီဒီယာသို့ CENO အား
ဝင်ရောက်သုံးစွဲခွင့် ပြု၊ မပြုကိုသင့်အား မေးနိုင်သည်- ဖိုင်ကို
သိမ်းဆည်းနိုင်ရန် ၎င်းကို လိုအပ်ပါသည်။
> 4. စာရင်းများ အလွန်အကျွံ ကြီးမားလာခြင်းကို ရှောင်ရှားရန် *စာရင်းဖိုင်ကို ဖွင့်မည်*
ကို အမှန်ခြစ်ဖြုတ်ပါ။
>
> You can now use the saved log file to document an issue report, but try to avoid
making it public since it may contain sensitive information about your browsing.
