<?xml version="1.0" encoding="UTF-8"?>
<MACROS>
<MACRO name="EAD to MARC Conversion (Papers)" lang="JScript">
ActiveDocument.Save();
var WSHShell = new ActiveXObject("Wscript.Shell");
var fs = new ActiveXObject("Scripting.FileSystemObject");
//Path to MARCXML conversion stylesheet
var ss = "\\\\netid\\lib\\docs\\librarycollections\\specialcollections\\ead\\EAD2MARCexport\\bin\\EAD2MARCXML.xsl"
var mn = "\\\\netid\\lib\\docs\\librarycollections\\specialcollections\\ead\\EAD2MARCexport\\bin\\MARC21slim2Mnemonic.xsl"
var sp = " ";
//Path to Java.exe
var jv = "C:\\PROGRA~2\\BLASTR~1\\XMETAL~1.5\\Author\\Display\\bin\\java.exe -showversion";
//Path to Jar
var jar = "-jar \\\\netid\\lib\\docs\\librarycollections\\specialcollections\\ead\\saxon.jar";
//Path and filename of XML file
var tFile = ActiveDocument.FullName;
//Path only to filename of the XML source file
var tPath = ActiveDocument.Path;
//FileName only
var tName = ActiveDocument.Name;
//Path to MARCXML output file
var tFile2 = tPath + "\\temp\\" + tName + ".marcxml";
var tFile3 = "\\\\netid\\lib\\docs\\librarycollections\\specialcollections\\ead\\ConnexionFiles\\" + tName + ".dat"
var cMarcEdit = "C:\\PROGRA~2\\BLASTR~1\\XMETAL~1.5\\Author\\XFT\\cmarcedit.exe";
var doMarc = cMarcEdit + sp + "-s " + tFile + sp + "-d " + tFile3 + " -xmltomarc -xslt " + ss + " -mxslt " + mn + " -marc8"
//Application.Alert(doMarc);
var op = "-o " + tFile2;
var allOp = jv + sp + jar + sp + op + sp + tFile + sp + ss;
//Application.Alert(jar + sp + op + sp + tFile + sp + ss);
if (tFile == "") {
Application.Alert("You must save your file first before using this macro")
} else {
//WSHShell.Run(allOp,1,"true");
WSHShell.Run(doMarc,1,"true");
}
</MACRO>
<MACRO name="EAD to MARC Conversion (Visual)" lang="JScript">
ActiveDocument.Save();
var WSHShell = new ActiveXObject("Wscript.Shell");
var fs = new ActiveXObject("Scripting.FileSystemObject");
//Path to MARCXML conversion stylesheet
var ss = "\\\\netid\\lib\\docs\\librarycollections\\specialcollections\\ead\\EAD2MARCexport\\bin\\EAD2PHMARCXML.xsl"
var mn = "\\\\netid\\lib\\docs\\librarycollections\\specialcollections\\ead\\EAD2MARCexport\\bin\\MARC21slim2Mnemonic.xsl"
var sp = " ";
//Path to Java.exe
var jv = "C:\\PROGRA~2\\BLASTR~1\\XMETAL~1.5\\Author\\Display\\bin\\java.exe -showversion";
//Path to Jar
var jar = "-jar \\\\netid\\lib\\docs\\librarycollections\\specialcollections\\ead\\saxon.jar";
//Path and filename of XML file
var tFile = ActiveDocument.FullName;
//Path only to filename of the XML source file
var tPath = ActiveDocument.Path;
//FileName only
var tName = ActiveDocument.Name;
//Path to MARCXML output file
var tFile2 = tPath + "\\temp\\" + tName + ".marcxml";
var tFile3 = "\\\\netid\\lib\\docs\\librarycollections\\specialcollections\\ead\\ConnexionFiles\\" + tName + ".dat"
var cMarcEdit = "C:\\PROGRA~2\\BLASTR~1\\XMETAL~1.5\\Author\\XFT\\cmarcedit.exe";
var doMarc = cMarcEdit + sp + "-s " + tFile + sp + "-d " + tFile3 + " -xmltomarc -xslt " + ss + " -mxslt " + mn + " -marc8"
//Application.Alert(doMarc);
var op = "-o " + tFile2;
var allOp = jv + sp + jar + sp + op + sp + tFile + sp + ss;
//Application.Alert(jar + sp + op + sp + tFile + sp + ss);
if (tFile == "") {
Application.Alert("You must save your file first before using this macro")
} else {
//WSHShell.Run(allOp,1,"true");
WSHShell.Run(doMarc,1,"true");
}
</MACRO>
    <MACRO name="Alma BBE" lang="JScript">
        ActiveDocument.Save();
        var WSHShell = new ActiveXObject("Wscript.Shell");
        var fs = new ActiveXObject("Scripting.FileSystemObject");
        var jv = "C:\\PROGRA~2\\BLASTR~1\\XMETAL~1.5\\Author\\Display\\bin\\java.exe -showversion";
        //var jv = "\\\\netid\\lib\\docs\\librarycollections\\specialcollections\\ead\\java\\jre\\bin\\java.exe -showversion";
        var jar = "-jar \\\\netid\\lib\\docs\\librarycollections\\specialcollections\\ead\\saxon.jar";
        var tFile = ActiveDocument.FullName;
        var tFile2 = tFile + "-ALMABBE.html";
        var tFile3 = "iexplore " + tFile2
        var ss = "\\\\netid\\lib\\docs\\librarycollections\\specialcollections\\stylesheets\\ALMABBE.xsl";
        var op = "-o " + tFile2;
        var sp = " ";
        var fn = "fileName=" + ActiveDocument.name;
        var allOp = jv + sp + jar + sp + op + sp + tFile + sp + ss + sp + fn;
        //Application.Alert(jar + sp + op + sp + tFile + sp + ss);
        if (tFile == "") {
        Application.Alert("You must save your file first before using this macro")
        } else {
        WSHShell.Run(allOp,1,"true");
        WSHShell.Run(tFile3,1,"false");
        }
    </MACRO>
    <MACRO name="Archives West Browse Terms List" lang="JScript">
        var WSHShell = new ActiveXObject("Wscript.Shell");
        WSHShell.Run("http://www.orbiscascade.org/file_viewer.php?id=1815")
    </MACRO>
    <MACRO name="Arrangement Compiler c01 Accession" lang="JScript">
        ActiveDocument.Save();
        var WSHShell = new ActiveXObject("Wscript.Shell");
        var fs = new ActiveXObject("Scripting.FileSystemObject");
        var jv = "C:\\PROGRA~2\\BLASTR~1\\XMETAL~1.5\\Author\\Display\\bin\\java.exe -showversion";
        //var jv = "\\\\netid\\lib\\docs\\librarycollections\\specialcollections\\ead\\java\\jre\\bin\\java.exe -showversion";
        var jar = "-jar \\\\netid\\lib\\docs\\librarycollections\\specialcollections\\ead\\saxon.jar";
        var tFile = ActiveDocument.FullName;
        var tFile2 = tFile + ".txt";
        var tFile3 = tFile2
        var ss = "\\\\netid\\lib\\docs\\librarycollections\\specialcollections\\stylesheets\\arrangementcompilerc01accession.xsl";
        var op = "-o " + tFile2;
        var sp = " ";
        var fn = "fileName=" + ActiveDocument.name;
        var allOp = jv + sp + jar + sp + op + sp + tFile + sp + ss + sp + fn;
        //Application.Alert(jar + sp + op + sp + tFile + sp + ss);
        if (tFile == "") {
        Application.Alert("You must save your file first before using this macro")
        } else {
        WSHShell.Run(allOp,1,"true");
        WSHShell.Run("wordpad.exe " + tFile2,1,"false");
        }
    </MACRO>
    <MACRO name="Arrangement Compiler c01 Series" lang="JScript">
        ActiveDocument.Save();
        var WSHShell = new ActiveXObject("Wscript.Shell");
        var fs = new ActiveXObject("Scripting.FileSystemObject");
        var jv = "C:\\PROGRA~2\\BLASTR~1\\XMETAL~1.5\\Author\\Display\\bin\\java.exe -showversion";
        //var jv = "\\\\netid\\lib\\docs\\librarycollections\\specialcollections\\ead\\java\\jre\\bin\\java.exe -showversion";
        var jar = "-jar \\\\netid\\lib\\docs\\librarycollections\\specialcollections\\ead\\saxon.jar";
        var tFile = ActiveDocument.FullName;
        var tFile2 = tFile + ".txt";
        var tFile3 = tFile2
        var ss = "\\\\netid\\lib\\docs\\librarycollections\\specialcollections\\stylesheets\\arrangementcompilerc01series.xsl";
        var op = "-o " + tFile2;
        var sp = " ";
        var fn = "fileName=" + ActiveDocument.name;
        var allOp = jv + sp + jar + sp + op + sp + tFile + sp + ss + sp + fn;
        //Application.Alert(jar + sp + op + sp + tFile + sp + ss);
        if (tFile == "") {
        Application.Alert("You must save your file first before using this macro")
        } else {
        WSHShell.Run(allOp,1,"true");
        WSHShell.Run("wordpad.exe " + tFile2,1,"false");
        }
    </MACRO>
    <MACRO name="Arrangement Compiler c02 Series" lang="JScript">
        ActiveDocument.Save();
        var WSHShell = new ActiveXObject("Wscript.Shell");
        var fs = new ActiveXObject("Scripting.FileSystemObject");
        var jv = "C:\\PROGRA~2\\BLASTR~1\\XMETAL~1.5\\Author\\Display\\bin\\java.exe -showversion";
        //var jv = "\\\\netid\\lib\\docs\\librarycollections\\specialcollections\\ead\\java\\jre\\bin\\java.exe -showversion";
        var jar = "-jar \\\\netid\\lib\\docs\\librarycollections\\specialcollections\\ead\\saxon.jar";
        var tFile = ActiveDocument.FullName;
        var tFile2 = tFile + ".txt";
        var tFile3 = tFile2
        var ss = "\\\\netid\\lib\\docs\\librarycollections\\specialcollections\\stylesheets\\arrangementcompilerc02series.xsl";
        var op = "-o " + tFile2;
        var sp = " ";
        var fn = "fileName=" + ActiveDocument.name;
        var allOp = jv + sp + jar + sp + op + sp + tFile + sp + ss + sp + fn;
        //Application.Alert(jar + sp + op + sp + tFile + sp + ss);
        if (tFile == "") {
        Application.Alert("You must save your file first before using this macro")
        } else {
        WSHShell.Run(allOp,1,"true");
        WSHShell.Run("wordpad.exe " + tFile2,1,"false");
        }
    </MACRO>
    <MACRO name="Date Compiler" lang="JScript">
        ActiveDocument.Save();
        var WSHShell = new ActiveXObject("Wscript.Shell");
        var fs = new ActiveXObject("Scripting.FileSystemObject");
        var jv = "C:\\PROGRA~2\\BLASTR~1\\XMETAL~1.5\\Author\\Display\\bin\\java.exe -showversion";
        //var jv = "\\\\netid\\lib\\docs\\librarycollections\\specialcollections\\ead\\java\\jre\\bin\\java.exe -showversion";
        var jar = "-jar \\\\netid\\lib\\docs\\librarycollections\\specialcollections\\ead\\saxon.jar";
        var tFile = ActiveDocument.FullName;
        var tFile2 = tFile + ".html";
        var tFile3 = "iexplore " + tFile2
        var ss = "\\\\netid\\lib\\docs\\librarycollections\\specialcollections\\stylesheets\\datecompiler.xsl";
        var op = "-o " + tFile2;
        var sp = " ";
        var fn = "fileName=" + ActiveDocument.name;
        var allOp = jv + sp + jar + sp + op + sp + tFile + sp + ss + sp + fn;
        //Application.Alert(jar + sp + op + sp + tFile + sp + ss);
        if (tFile == "") {
        Application.Alert("You must save your file first before using this macro")
        } else {
        WSHShell.Run(allOp,1,"true");
        WSHShell.Run(tFile3,1,"false");
        }
    </MACRO>
    <MACRO name="MARC 856" lang="JScript">
        ActiveDocument.Save();
        var WSHShell = new ActiveXObject("Wscript.Shell");
        var fs = new ActiveXObject("Scripting.FileSystemObject");
        var jv = "C:\\PROGRA~2\\BLASTR~1\\XMETAL~1.5\\Author\\Display\\bin\\java.exe -showversion";
        //var jv = "\\\\netid\\lib\\docs\\librarycollections\\specialcollections\\ead\\java\\jre\\bin\\java.exe -showversion";
        var jar = "-jar \\\\netid\\lib\\docs\\librarycollections\\specialcollections\\ead\\saxon.jar";
        var tFile = ActiveDocument.FullName;
        var tFile2 = tFile + "-MARC856.html";
        var tFile3 = "iexplore " + tFile2
        var ss = "\\\\netid\\lib\\docs\\librarycollections\\specialcollections\\stylesheets\\MARC856Compiler.xsl";
        var op = "-o " + tFile2;
        var sp = " ";
        var fn = "fileName=" + ActiveDocument.name;
        var allOp = jv + sp + jar + sp + op + sp + tFile + sp + ss + sp + fn;
        //Application.Alert(jar + sp + op + sp + tFile + sp + ss);
        if (tFile == "") {
        Application.Alert("You must save your file first before using this macro")
        } else {
        WSHShell.Run(allOp,1,"true");
        WSHShell.Run(tFile3,1,"false");
        }
    </MACRO>    
    <MACRO name="Restrictions Compiler" lang="JScript">
        ActiveDocument.Save();
        var WSHShell = new ActiveXObject("Wscript.Shell");
        var fs = new ActiveXObject("Scripting.FileSystemObject");
        var jv = "C:\\PROGRA~2\\BLASTR~1\\XMETAL~1.5\\Author\\Display\\bin\\java.exe -showversion";
        //var jv = "\\\\netid\\lib\\docs\\librarycollections\\specialcollections\\ead\\java\\jre\\bin\\java.exe -showversion";
        var jar = "-jar \\\\netid\\lib\\docs\\librarycollections\\specialcollections\\ead\\saxon.jar";
        var tFile = ActiveDocument.FullName;
        var tFile2 = tFile + ".html";
        var tFile3 = "iexplore " + tFile2
        var ss = "\\\\netid\\lib\\docs\\librarycollections\\specialcollections\\stylesheets\\restrictionscompiler.xsl";
        var op = "-o " + tFile2;
        var sp = " ";
        var fn = "fileName=" + ActiveDocument.name;
        var allOp = jv + sp + jar + sp + op + sp + tFile + sp + ss + sp + fn;
        //Application.Alert(jar + sp + op + sp + tFile + sp + ss);
        if (tFile == "") {
        Application.Alert("You must save your file first before using this macro")
        } else {
        WSHShell.Run(allOp,1,"true");
        WSHShell.Run(tFile3,1,"false");
        }
    </MACRO>
    <MACRO name="Scope and Content Compiler" lang="JScript">
        ActiveDocument.Save();
        var WSHShell = new ActiveXObject("Wscript.Shell");
        var fs = new ActiveXObject("Scripting.FileSystemObject");
        var jv = "C:\\PROGRA~2\\BLASTR~1\\XMETAL~1.5\\Author\\Display\\bin\\java.exe -showversion";
        //var jv = "\\\\netid\\lib\\docs\\librarycollections\\specialcollections\\ead\\java\\jre\\bin\\java.exe -showversion";
        var jar = "-jar \\\\netid\\lib\\docs\\librarycollections\\specialcollections\\ead\\saxon.jar";
        var tFile = ActiveDocument.FullName;
        var tFile2 = tFile + ".html";
        var tFile3 = "iexplore " + tFile2
        var ss = "\\\\netid\\lib\\docs\\librarycollections\\specialcollections\\stylesheets\\scopecompiler.xsl";
        var op = "-o " + tFile2;
        var sp = " ";
        var fn = "fileName=" + ActiveDocument.name;
        var allOp = jv + sp + jar + sp + op + sp + tFile + sp + ss + sp + fn;
        //Application.Alert(jar + sp + op + sp + tFile + sp + ss);
        if (tFile == "") {
        Application.Alert("You must save your file first before using this macro")
        } else {
        WSHShell.Run(allOp,1,"true");
        WSHShell.Run(tFile3,1,"false");
        }
    </MACRO>
    <MACRO name="Shift Levels Down" lang="JScript">
        //Default response is NO
        var response = 7;
        response = Application.MessageBox("WARNING! This macro will shift all of the component levels (c01, c02, etc.) in the entire document down one level. Are you sure that you want to do this?",52,"Warning...about to alter document");
        if (response==6) {
        ActiveDocument.ViewType=2;
        Application.DisplayAlerts = sqAlertsNone;
        Selection.Find.Execute("c09", "c10", "", false, true, false, true, true, 3);
        Selection.Find.Execute("c08", "c09", "", false, true, false, true, true, 3);
        Selection.Find.Execute("c07", "c08", "", false, true, false, true, true, 3);
        Selection.Find.Execute("c06", "c07", "", false, true, false, true, true, 3);
        Selection.Find.Execute("c05", "c06", "", false, true, false, true, true, 3);
        Selection.Find.Execute("c04", "c05", "", false, true, false, true, true, 3);
        Selection.Find.Execute("c03", "c04", "", false, true, false, true, true, 3);
        Selection.Find.Execute("c02", "c03", "", false, true, false, true, true, 3);
        Selection.Find.Execute("c01", "c02", "", false, true, false, true, true, 3);
        Selection.HomeKey(1);
        Selection.Find.Execute("&lt;c02");
        Selection.MoveLeft();
        Selection.TypeText("&lt;c01 level='otherlevel' otherlevel='accession'&gt;&lt;did&gt;&lt;unitid type='accession' encodinganalog='099'&gt;&lt;/unitid&gt;&lt;/did&gt;");
        Selection.Find.Execute("&lt;/dsc&gt;");
        Selection.MoveLeft();
        Selection.TypeText("&lt;/c01&gt;");
        Selection.HomeKey(1);
        Selection.Find.Execute("&lt;c01");
        ActiveDocument.ViewType=1;
        Application.DisplayAlerts = sqAlertsAll;
        Application.MessageBox("All done...\n\nClick on Edit--Undo if the changes were not as expected",64,"Macro finished");
        }
    </MACRO>
    <MACRO name="Shift Levels Up (Merging Accessions Only)" lang="JScript">
        //Default response is NO
        var response = 7;
        response = Application.MessageBox("WARNING! This macro will shift all of the component levels (c01, c02, etc.) in the entire document UP one level. If you haven't done this before, you are strongly advised to talk to Mark or Emily first. Do you want to continue?",52,"Warning...about to alter document");
        if (response==6) {
        ActiveDocument.ViewType=2;
        Application.DisplayAlerts = sqAlertsNone;
        Selection.Find.Execute("c02", "c01", "", false, true, false, true, true, 3);
        Selection.Find.Execute("c03", "c02", "", false, true, false, true, true, 3);
        Selection.Find.Execute("c04", "c03", "", false, true, false, true, true, 3);
        Selection.Find.Execute("c05", "c04", "", false, true, false, true, true, 3);
        Selection.Find.Execute("c06", "c05", "", false, true, false, true, true, 3);
        Selection.Find.Execute("c07", "c06", "", false, true, false, true, true, 3);
        Selection.Find.Execute("c08", "c07", "", false, true, false, true, true, 3);
        Selection.Find.Execute("c09", "c08", "", false, true, false, true, true, 3);
        Selection.Find.Execute("c10", "c09", "", false, true, false, true, true, 3);
        Selection.HomeKey(1);
        Application.MessageBox("You will need to manually remove the extra c01 data at the beginning and end of the document.",64,"Macro finished");
        Application.DisplayAlerts = sqAlertsAll;
        Application.MessageBox("All done...\n\nClick on Edit--Undo if the changes were not as expected",64,"Macro finished");
        }
    </MACRO>
    <MACRO name="Size Compiler c01 Accession" lang="JScript">
        ActiveDocument.Save();
        var WSHShell = new ActiveXObject("Wscript.Shell");
        var fs = new ActiveXObject("Scripting.FileSystemObject");
        var jv = "C:\\PROGRA~2\\BLASTR~1\\XMETAL~1.5\\Author\\Display\\bin\\java.exe -showversion";
        //var jv = "\\\\netid\\lib\\docs\\librarycollections\\specialcollections\\ead\\java\\jre\\bin\\java.exe -showversion";
        var jar = "-jar \\\\netid\\lib\\docs\\librarycollections\\specialcollections\\ead\\saxon.jar";
        var tFile = ActiveDocument.FullName;
        var tFile2 = tFile + ".html";
        var tFile3 = "iexplore " + tFile2
        var ss = "\\\\netid\\lib\\docs\\librarycollections\\specialcollections\\stylesheets\\sizecompiler.xsl";
        var op = "-o " + tFile2;
        var sp = " ";
        var fn = "fileName=" + ActiveDocument.name;
        var allOp = jv + sp + jar + sp + op + sp + tFile + sp + ss + sp + fn;
        //Application.Alert(jar + sp + op + sp + tFile + sp + ss);
        if (tFile == "") {
        Application.Alert("You must save your file first before using this macro")
        } else {
        WSHShell.Run(allOp,1,"true");
        WSHShell.Run(tFile3,1,"false");
        WSHShell.run("calc")
        }
    </MACRO>
    <MACRO name="Size Compiler c02 Accession" lang="JScript">
        ActiveDocument.Save();
        var WSHShell = new ActiveXObject("Wscript.Shell");
        var fs = new ActiveXObject("Scripting.FileSystemObject");
        var jv = "C:\\PROGRA~2\\BLASTR~1\\XMETAL~1.5\\Author\\Display\\bin\\java.exe -showversion";
        //var jv = "\\\\netid\\lib\\docs\\librarycollections\\specialcollections\\ead\\java\\jre\\bin\\java.exe -showversion";
        var jar = "-jar \\\\netid\\lib\\docs\\librarycollections\\specialcollections\\ead\\saxon.jar";
        var tFile = ActiveDocument.FullName;
        var tFile2 = tFile + ".html";
        var tFile3 = "iexplore " + tFile2
        var ss = "\\\\netid\\lib\\docs\\librarycollections\\specialcollections\\stylesheets\\sizecompilerc02.xsl";
        var op = "-o " + tFile2;
        var sp = " ";
        var fn = "fileName=" + ActiveDocument.name;
        var allOp = jv + sp + jar + sp + op + sp + tFile + sp + ss + sp + fn;
        //Application.Alert(jar + sp + op + sp + tFile + sp + ss);
        if (tFile == "") {
        Application.Alert("You must save your file first before using this macro")
        } else {
        WSHShell.Run(allOp,1,"true");
        WSHShell.Run(tFile3,1,"false");
        WSHShell.run("calc")
        }
    </MACRO>
</MACROS>    
