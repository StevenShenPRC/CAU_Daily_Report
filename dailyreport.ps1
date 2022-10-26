$date = (get-date -format 'yyyyMMdd')
$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession #设定变量 $session 以达到在反复出现的命令里替代一长串字符的功能
$session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36 Edg/106.0.1370.52" #User Agent (UA)
$session.Cookies.Add((New-Object System.Net.Cookie("eai-sess", "<cookies value>", "/", "wep.cau.edu.cn"))) #加入cookies
$session.Cookies.Add((New-Object System.Net.Cookie("UUkey", "<cookies value>", "/", "wep.cau.edu.cn"))) #同上，另一个cookies，请将<cookies value>完全替换成值，比如: $session.Cookies.Add((New-Object System.Net.Cookie("UUkey", "47b1246ad63bf80345184dd7697737", "/", "wep.cau.edu.cn")))
$hsts = (   <#hsts 代表 “核酸天数”，加入变量 $hsts 以判断昨日是否核酸，方法是请求农大的健康码并从中获取天数信息（北京健康宝的不敢搞）#>
Invoke-WebRequest -UseBasicParsing -Uri "https://wep.cau.edu.cn/healthcode/wap/default/dindex" `
-Method "POST" `
-WebSession $session `
-Headers @{
"Accept"="application/json, text/plain, */*"
  "Accept-Encoding"="gzip, deflate, br"
  "Accept-Language"="zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6"
  "Origin"="https://wep.cau.edu.cn"
  "Referer"="https://wep.cau.edu.cn/site/epidehealth/masterqrcode?door_id=592"
  "Sec-Fetch-Dest"="empty"
  "Sec-Fetch-Mode"="cors"
  "Sec-Fetch-Site"="same-origin"
  "X-Requested-With"="XMLHttpRequest"
  "sec-ch-ua"="`"Chromium`";v=`"106`", `"Microsoft Edge`";v=`"106`", `"Not;A=Brand`";v=`"99`""
  "sec-ch-ua-mobile"="?0"
  "sec-ch-ua-platform"="`"Windows`""
} `
-ContentType "application/x-www-form-urlencoded" `
-Body "door_id=592&iaaa_token=") #前面的都是前戏，现在开始正式请求农大健康码
if ( $hsts -like '*"days":1*' ){ #判断昨日是否核酸
  $session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.26 Safari/537.36"
$session.Cookies.Add((New-Object System.Net.Cookie("eai-sess", "a91u9jq0p626ho48imslg466c0", "/", "wep.cau.edu.cn")))
$session.Cookies.Add((New-Object System.Net.Cookie("UUkey", "e47b14663bf80184dd7697374e8336ff", "/", "wep.cau.edu.cn")))
Invoke-WebRequest -UseBasicParsing -Uri "https://wep.cau.edu.cn/cauncovxs/wap/default/save" `
-Method "POST" `
-WebSession $session `
-Headers @{
"Accept"="application/json, text/javascript, */*; q=0.01"
  "Accept-Encoding"="gzip, deflate, br"
  "Accept-Language"="zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6"
  "Origin"="https://wep.cau.edu.cn"
  "Referer"="https://wep.cau.edu.cn/cauncovxs/wap/default/index"
  "Sec-Fetch-Dest"="empty"
  "Sec-Fetch-Mode"="cors"
  "Sec-Fetch-Site"="same-origin"
  "X-Requested-With"="XMLHttpRequest"
  "sec-ch-ua"="`"Chromium`";v=`"106`", `"Microsoft Edge`";v=`"106`", `"Not;A=Brand`";v=`"99`""
  "sec-ch-ua-mobile"="?0"
  "sec-ch-ua-platform"="`"Windows`""
} `
-ContentType "application/x-www-form-urlencoded; charset=UTF-8" `
-Body "ismoved=0&jhfjrq=&jhfjjtgj=&jhfjhbcc=&sfxk=0&xkqq=&szgj=&szcs=&sfyxgl=0&sfbdzd=0&sftjgfxdq=0&sftjzfxdq=0&sfjcgfxry=0&sfjczfxry=0&todaysfhsjc=%E6%98%AF&sfyjzxgym=1&xgymjzd=3&sfwcdszxgym=1&tzryyqxgqk=0&tw=11&sfcxtz=0&sfjcbh=0&sfcxzysx=0&qksm=&sfyyjc=0&jcjgqr=0&remark=&address=%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E9%A9%AC%E8%BF%9E%E6%B4%BC%E8%A1%97%E9%81%93%E7%BB%BF%E8%8B%91%E8%A5%BF%E8%B7%AF%E4%B8%AD%E5%9B%BD%E5%86%9C%E4%B8%9A%E5%A4%A7%E5%AD%A6%E8%A5%BF%E6%A0%A1%E5%8C%BA&geo_api_info=%7B%22type%22%3A%22complete%22%2C%22position%22%3A%7B%22Q%22%3A40.025995279948%2C%22R%22%3A116.278875054254%2C%22lng%22%3A116.278875%2C%22lat%22%3A40.025995%7D%2C%22location_type%22%3A%22html5%22%2C%22message%22%3A%22Get+ipLocation+failed.Get+geolocation+success.Convert+Success.Get+address+success.%22%2C%22accuracy%22%3A111%2C%22isConverted%22%3Atrue%2C%22status%22%3A1%2C%22addressComponent%22%3A%7B%22citycode%22%3A%22010%22%2C%22adcode%22%3A%22110108%22%2C%22businessAreas%22%3A%5B%7B%22name%22%3A%22%E9%A9%AC%E8%BF%9E%E6%B4%BC%22%2C%22id%22%3A%22110108%22%2C%22location%22%3A%7B%22Q%22%3A40.028654%2C%22R%22%3A116.28115600000001%2C%22lng%22%3A116.281156%2C%22lat%22%3A40.028654%7D%7D%2C%7B%22name%22%3A%22%E8%A5%BF%E5%8C%97%E6%97%BA%22%2C%22id%22%3A%22110108%22%2C%22location%22%3A%7B%22Q%22%3A40.054273%2C%22R%22%3A116.256057%2C%22lng%22%3A116.256057%2C%22lat%22%3A40.054273%7D%7D%2C%7B%22name%22%3A%22%E4%B8%8A%E5%9C%B0%22%2C%22id%22%3A%22110108%22%2C%22location%22%3A%7B%22Q%22%3A40.035542%2C%22R%22%3A116.30327599999998%2C%22lng%22%3A116.303276%2C%22lat%22%3A40.035542%7D%7D%5D%2C%22neighborhoodType%22%3A%22%22%2C%22neighborhood%22%3A%22%22%2C%22building%22%3A%22%22%2C%22buildingType%22%3A%22%22%2C%22street%22%3A%22%E5%9C%86%E6%98%8E%E5%9B%AD%E8%A5%BF%E8%B7%AF%22%2C%22streetNumber%22%3A%228%E5%8F%B7%22%2C%22country%22%3A%22%E4%B8%AD%E5%9B%BD%22%2C%22province%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%22%2C%22city%22%3A%22%22%2C%22district%22%3A%22%E6%B5%B7%E6%B7%80%E5%8C%BA%22%2C%22towncode%22%3A%22110108020000%22%2C%22township%22%3A%22%E9%A9%AC%E8%BF%9E%E6%B4%BC%E8%A1%97%E9%81%93%22%7D%2C%22formattedAddress%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E9%A9%AC%E8%BF%9E%E6%B4%BC%E8%A1%97%E9%81%93%E7%BB%BF%E8%8B%91%E8%A5%BF%E8%B7%AF%E4%B8%AD%E5%9B%BD%E5%86%9C%E4%B8%9A%E5%A4%A7%E5%AD%A6%E8%A5%BF%E6%A0%A1%E5%8C%BA%22%2C%22roads%22%3A%5B%5D%2C%22crosses%22%3A%5B%5D%2C%22pois%22%3A%5B%5D%2C%22info%22%3A%22SUCCESS%22%7D&area=%E5%8C%97%E4%BA%AC%E5%B8%82++%E6%B5%B7%E6%B7%80%E5%8C%BA&province=%E5%8C%97%E4%BA%AC%E5%B8%82&city=%E5%8C%97%E4%BA%AC%E5%B8%82&sfzx=1&sfjcwhry=0&sfjchbry=0&sfcyglq=0&gllx=&glksrq=&jcbhlx=&jcbhrq=&bztcyy=&sftjhb=0&sftjwh=0&sfsfbh=0&xjzd=&jcwhryfs=&jchbryfs=&szsqsfybl=0&sfygtjzzfj=0&gtjzzfjsj=&jcjg=&date=$date&uid=88069&created=1666433017&jcqzrq=&sfjcqz=&id=12110094&gwszdd=&sfyqjzgc=&jrsfqzys=&jrsfqzfy=&sfsqhzjkk=&sqhzjkkys=&szgjcs="
  } #向服务器发送带有上报信息信息的post请求，这是昨日已经核酸了的
  else { 
    $session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.26 Safari/537.36"
$session.Cookies.Add((New-Object System.Net.Cookie("eai-sess", "a91u9jq0p626ho48imslg466c0", "/", "wep.cau.edu.cn")))
$session.Cookies.Add((New-Object System.Net.Cookie("UUkey", "e47b14663bf80184dd7697374e8336ff", "/", "wep.cau.edu.cn")))
Invoke-WebRequest -UseBasicParsing -Uri "https://wep.cau.edu.cn/cauncovxs/wap/default/save" `
-Method "POST" `
-WebSession $session `
-Headers @{
"Accept"="application/json, text/javascript, */*; q=0.01"
  "Accept-Encoding"="gzip, deflate, br"
  "Accept-Language"="zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6"
  "Origin"="https://wep.cau.edu.cn"
  "Referer"="https://wep.cau.edu.cn/cauncovxs/wap/default/index"
  "Sec-Fetch-Dest"="empty"
  "Sec-Fetch-Mode"="cors"
  "Sec-Fetch-Site"="same-origin"
  "X-Requested-With"="XMLHttpRequest"
  "sec-ch-ua"="`"Chromium`";v=`"106`", `"Microsoft Edge`";v=`"106`", `"Not;A=Brand`";v=`"99`""
  "sec-ch-ua-mobile"="?0"
  "sec-ch-ua-platform"="`"Windows`""
} `
-ContentType "application/x-www-form-urlencoded; charset=UTF-8" `
-Body "ismoved=0&jhfjrq=&jhfjjtgj=&jhfjhbcc=&sfxk=0&xkqq=&szgj=&szcs=&sfyxgl=0&sfbdzd=0&sftjgfxdq=0&sftjzfxdq=0&sfjcgfxry=0&sfjczfxry=0&todaysfhsjc=%E5%90%A6&sfyjzxgym=1&xgymjzd=3&sfwcdszxgym=1&tzryyqxgqk=0&tw=11&sfcxtz=0&sfjcbh=0&sfcxzysx=0&qksm=&sfyyjc=0&jcjgqr=0&remark=&address=%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E9%A9%AC%E8%BF%9E%E6%B4%BC%E8%A1%97%E9%81%93%E7%BB%BF%E8%8B%91%E8%A5%BF%E8%B7%AF%E4%B8%AD%E5%9B%BD%E5%86%9C%E4%B8%9A%E5%A4%A7%E5%AD%A6%E8%A5%BF%E6%A0%A1%E5%8C%BA&geo_api_info=%7B%22type%22%3A%22complete%22%2C%22position%22%3A%7B%22Q%22%3A40.025995279948%2C%22R%22%3A116.278875054254%2C%22lng%22%3A116.278875%2C%22lat%22%3A40.025995%7D%2C%22location_type%22%3A%22html5%22%2C%22message%22%3A%22Get+ipLocation+failed.Get+geolocation+success.Convert+Success.Get+address+success.%22%2C%22accuracy%22%3A111%2C%22isConverted%22%3Atrue%2C%22status%22%3A1%2C%22addressComponent%22%3A%7B%22citycode%22%3A%22010%22%2C%22adcode%22%3A%22110108%22%2C%22businessAreas%22%3A%5B%7B%22name%22%3A%22%E9%A9%AC%E8%BF%9E%E6%B4%BC%22%2C%22id%22%3A%22110108%22%2C%22location%22%3A%7B%22Q%22%3A40.028654%2C%22R%22%3A116.28115600000001%2C%22lng%22%3A116.281156%2C%22lat%22%3A40.028654%7D%7D%2C%7B%22name%22%3A%22%E8%A5%BF%E5%8C%97%E6%97%BA%22%2C%22id%22%3A%22110108%22%2C%22location%22%3A%7B%22Q%22%3A40.054273%2C%22R%22%3A116.256057%2C%22lng%22%3A116.256057%2C%22lat%22%3A40.054273%7D%7D%2C%7B%22name%22%3A%22%E4%B8%8A%E5%9C%B0%22%2C%22id%22%3A%22110108%22%2C%22location%22%3A%7B%22Q%22%3A40.035542%2C%22R%22%3A116.30327599999998%2C%22lng%22%3A116.303276%2C%22lat%22%3A40.035542%7D%7D%5D%2C%22neighborhoodType%22%3A%22%22%2C%22neighborhood%22%3A%22%22%2C%22building%22%3A%22%22%2C%22buildingType%22%3A%22%22%2C%22street%22%3A%22%E5%9C%86%E6%98%8E%E5%9B%AD%E8%A5%BF%E8%B7%AF%22%2C%22streetNumber%22%3A%228%E5%8F%B7%22%2C%22country%22%3A%22%E4%B8%AD%E5%9B%BD%22%2C%22province%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%22%2C%22city%22%3A%22%22%2C%22district%22%3A%22%E6%B5%B7%E6%B7%80%E5%8C%BA%22%2C%22towncode%22%3A%22110108020000%22%2C%22township%22%3A%22%E9%A9%AC%E8%BF%9E%E6%B4%BC%E8%A1%97%E9%81%93%22%7D%2C%22formattedAddress%22%3A%22%E5%8C%97%E4%BA%AC%E5%B8%82%E6%B5%B7%E6%B7%80%E5%8C%BA%E9%A9%AC%E8%BF%9E%E6%B4%BC%E8%A1%97%E9%81%93%E7%BB%BF%E8%8B%91%E8%A5%BF%E8%B7%AF%E4%B8%AD%E5%9B%BD%E5%86%9C%E4%B8%9A%E5%A4%A7%E5%AD%A6%E8%A5%BF%E6%A0%A1%E5%8C%BA%22%2C%22roads%22%3A%5B%5D%2C%22crosses%22%3A%5B%5D%2C%22pois%22%3A%5B%5D%2C%22info%22%3A%22SUCCESS%22%7D&area=%E5%8C%97%E4%BA%AC%E5%B8%82++%E6%B5%B7%E6%B7%80%E5%8C%BA&province=%E5%8C%97%E4%BA%AC%E5%B8%82&city=%E5%8C%97%E4%BA%AC%E5%B8%82&sfzx=1&sfjcwhry=0&sfjchbry=0&sfcyglq=0&gllx=&glksrq=&jcbhlx=&jcbhrq=&bztcyy=&sftjhb=0&sftjwh=0&sfsfbh=0&xjzd=&jcwhryfs=&jchbryfs=&szsqsfybl=0&sfygtjzzfj=0&gtjzzfjsj=&jcjg=&date=$date&uid=88069&created=1666433017&jcqzrq=&sfjcqz=&id=12110094&gwszdd=&sfyqjzgc=&jrsfqzys=&jrsfqzfy=&sfsqhzjkk=&sqhzjkkys=&szgjcs="
    } #那如果没找到"days":1就是核酸超过一天，就是昨天没核酸，所以发送昨日未核酸的请求
