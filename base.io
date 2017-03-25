//basefile
//written by peppo
//***discription********************************
//*this program sent httprequest 2 httpserver TEMPLATE.
//*then return any code.
//*Try it.
//*arg 0:programname,1:URL,2:logfilename
//*rslt = logfilename.txt
//**********************************************
//global variables
base := method(
  SGML#use SGML addon!
  //initAndReserveArgs
  htmlExtension := ".xml"//logfile's extension
  textExtension := ".txt"//logfile's extension
  Bot := Object clone do(//root object!
    target := System args at(1)//URL ascii
    logname := System args at(2)//logfilename ascii
    //emulate cURL!
    rslt := ""
    HC := HttpClient clone//clone Httpclient 4 use HCUrl
    HC HCRequest setHeader("User-Agent","Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36")//user fake UA EGDE
    HC HCRequest setHeader("Referer",target)//anysite need this
    HC HCRequest setHeader("Host",target splitNoEmpties("/") at(1))//set fake host header
    HC HCRequest setHeader("Accept","*/*")//set mediatype
    HC HCRequest setHeader("Cache-Control","max-age=0")//Cache-Control
    HC HCRequest setHeader("Connection","keep-alive")//connection setting
    //Bot HC HCRequest setHeader("charset","UTF-8")//set charset
    HC HCUrl urlSeq := target //url ready up!
  )

  Bot rslt = Bot HC HCUrl getResponse content//fire

  //logging
  logfile := File with(System launchPath .. "/" .. Bot logname .. htmlExtension)
  logfile remove//if exist filename, then remove file.
  logfile openForUpdating setContents(Bot rslt) close//write and close log
  //convert charset any to utf8 through bash
  sh := System clone
  sh system("nkf -w -b --overwrite " .. System launchPath .. "/" .. Bot logname .. htmlExtension)
  File with(System launchPath .. "/" .. Bot logname .. htmlExtension) contents
  exit
)
base()
//TODO//
