<%
if Session("grantAccess") <> 1 then 
	Response.Redirect "login.html"
end if
%>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<TITLE></TITLE>
</HEAD>
<BODY  bgcolor=lightgrey>
<input type="hidden" id="operation_id" name="operation_id" value="<%=Session("operation_id")%>">
<FORM action=formSubmit.asp method="post">

<INPUT type="hidden" id=recostr name=recostr value="<%=Session("postoprecostr")%>">
<CENTER>
<TABLE WIDTH=* BORDER=0 CELLSPACING=0 CELLPADDING=0>
	<TR>
		<TD colspan=2 rowspan=2 align=left width=* height=350 valign=top>
		<FONT size=+1><B>Postoperative Recommendations</B></FONT>
	<HR width=320 align=left>
	<TABLE WIDTH=* BORDER=0 CELLSPACING=4 CELLPADDING=1>

			<%
			Set sqlconnection = Server.CreateObject("ADODB.Connection")
			
			sqlconnection.Open session("dbColonDSN"),session("dbUsername"),session("dbPassword")
			if Session("optype")="colonoscopy" then
				rs.Open "SELECT * FROM id_colon_recommendations", sqlconnection
				rs.Open "SELECT * FROM id_egd_recommendations", sqlconnection
			
			if (not rs.EOF) then
				do until rs.EOF
					preLineCount=0
					Response.Write "<TR>" + vbcrlf
					do until preLineCount>=1 or rs.eof
						if InStr(1,Session("postoprecostr"), Cstr(rs.Fields("id")) + ",") > 0 then
						Response.Write "<TD width=41><INPUT type=checkbox id=" + Cstr(rs.Fields("id")) + " name=" + Cstr(rs.Fields("id")) + " style=""WIDTH: 40px; HEIGHT: 40px"" size=41 onclick=""document.forms[0].recostr.value=document.forms[0].recostr.value+'" + Cstr(rs.Fields("id")) + "," + "';"" checked></TD>" + vbcrlf
						else
						Response.Write "<TD width=41><INPUT type=checkbox id=" + Cstr(rs.Fields("id")) + " name=" + Cstr(rs.Fields("id")) + " style=""WIDTH: 40px; HEIGHT: 40px"" size=41 onclick=""document.forms[0].recostr.value=document.forms[0].recostr.value+'" + Cstr(rs.Fields("id")) + "," + "';""></TD>" + vbcrlf
						end if
						Response.Write "<TD><FONT size=+1>" + Cstr(rs.Fields("text")) + "</FONT></TD>" + vbcrlf
						preLineCount=preLineCount+1
						rs.MoveNext
					loop
					Response.Write "</TR>" + vbcrlf
				loop
			end if

			rs.close
			sqlconnection.close
			%>
</TABLE>
<TABLE width=320 border=0 CELLSPACING=0 CELLPADDING=0>
	<TR>
		<TD><INPUT id=exitBtn style="FONT-WEIGHT: bold; FONT-SIZE: larger; WIDTH: 105px; COLOR: white; FONT-FAMILY: monospace; HEIGHT: 76px; BACKGROUND-COLOR: black" type=button size=31 value="Back" name=exitBtn onclick="document.location.href='postopmenu.html'"></TD>
		<TD colspan=2 align=right><INPUT id=nextBtn style="FONT-WEIGHT: bold; FONT-SIZE: larger; WIDTH: 105px; COLOR: black; FONT-FAMILY: monospace; HEIGHT: 76px; BACKGROUND-COLOR: grey" type=submit size=31 value="Ok" name=nextBtn></TD>
	</TR>
</TABLE>
</CENTER>
<input type="hidden" name="type" value="postoprecommend">
</FORM>
</BODY>
</HTML>

