<%@ Page Title="BEST - Tutor Information" Language="C#" MasterPageFile="~/Best.Master" AutoEventWireup="true" CodeBehind="TutorPersonal.aspx.cs" Inherits="BaliEnterpriseSystems.TutorPersonal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

<asp:Literal ID="ltrMScript" runat="server">
</asp:Literal>
<asp:Literal ID="ltrScript" runat="server"></asp:Literal>

    <script language="javascript" type="text/javascript">
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="MidCenDiv">
	    <div class="ContentCenDiv">
    	    <div class="ContentbrdrDiv">
			    <div class="LeftNav">
				    <ul>
                        <asp:Literal ID="ltrSubMenu" runat="server"></asp:Literal>
				    </ul>
			    </div>
                <div><asp:Literal ID="ltrValidateMsg" runat="server"></asp:Literal></div>
		        <div class="CAreaDiv">
                <asp:Literal ID="ltrPersonalData" runat="server"></asp:Literal>
                <br />
                <table cellpadding="0" cellspacing="0" style="padding-top:10px; width: 800px;" >
                <tr><td colspan="">&nbsp;Tutor Infomation</td></tr>
                <tr><td><table style="border:1px solid #884a0a;background-color:#EEE;">
                    <tr><td>Tutor Id:&nbsp;</td><td><asp:Literal ID="ltrtid" runat="server" Text="-"></asp:Literal></td>
                <td class="style9">First Name:&nbsp;&nbsp; </td><td><asp:Literal ID="ltrfname" runat="server" Text="-"></asp:Literal></td>            </tr>
                <tr>
                    <td class="style10">Last Name:&nbsp;&nbsp; </td><td class="style7">
                    <asp:Literal ID="ltrlname" 
                        runat="server" Text="-"></asp:Literal></td>            
                    <td class="style9">Middle Name:&nbsp;&nbsp; </td><td>
                    <asp:Literal ID="ltrmidname" runat="server" Text="-"></asp:Literal></td>
                </tr>            
                <tr>
                    <td class="style10">Joining Date:&nbsp;&nbsp; </td><td class="style7">
                    <asp:Literal ID="ltrjoindate" 
                        runat="server" Text="-"></asp:Literal></td>
                    <td class="style9">Gender:&nbsp;&nbsp; </td><td>
                    <asp:Literal ID="ltrgender" 
                            runat="server" Text="-"></asp:Literal></td>
                </tr>            
                <tr>
                    <td class="style10">Address 1:&nbsp;&nbsp; </td><td class="style7">
                    <asp:Literal ID="ltradd1" runat="server" Text="-"></asp:Literal></td>
                    <td class="style9">Address 2:&nbsp;&nbsp; </td><td><asp:Literal ID="ltradd2" 
                        runat="server" Text="-"></asp:Literal></td>
                </tr>            
                <tr>
                    <td class="style10">City:&nbsp;&nbsp; </td><td class="style7">
                    <asp:Literal ID="ltrcity" runat="server" Text="-"></asp:Literal></td>
                    <td class="style9">State:&nbsp;&nbsp; </td><td class="la">
                    <asp:Literal ID="ltrstate" 
                        runat="server" Text="-"></asp:Literal></td></tr>            
                <tr>
                    <td class="style10">Zip:&nbsp;&nbsp; </td><td class="style8">
                    <asp:Literal ID="ltrzip" runat="server" Text="-"></asp:Literal></td>
                    <td class="style9">Cell Phone:&nbsp;&nbsp; </td><td><asp:Literal ID="ltrcell" 
                        runat="server" Text="-"></asp:Literal></td>
                </tr>            
                <tr>
                    <td class="style10">Work Phone:&nbsp;&nbsp; </td><td class="style7">
                    <asp:Literal ID="ltrwph" runat="server" Text="-"></asp:Literal></td>
                    <td class="style9">Home Phone:&nbsp;&nbsp; </td><td><asp:Literal ID="ltrhomep" 
                        runat="server" Text="-"></asp:Literal></td>
                </tr>            
                <tr>
                    <td class="style10">&nbsp;E-Mail:&nbsp;&nbsp; </td><td class="style7">
                    <asp:Literal ID="ltremail" runat="server" Text="-"></asp:Literal></td>            
                    <td class="style9">GPA:&nbsp;&nbsp; </td><td>
                    <asp:Literal ID="ltrgap" runat="server" Text="-"></asp:Literal></td>
                </tr>
                <tr>
                   <td class="style11">ProgramStyle:&nbsp;&nbsp; </td><td class="style12">
                    <asp:Literal ID="ltrpst" runat="server" Text="-"></asp:Literal> </td>
                   <td class="style13">School:&nbsp;&nbsp; </td><td class="style14">
                    <asp:Literal ID="ltrschool" runat="server" Text="-"></asp:Literal></td>            
            </tr>
                <tr>
                   <td class="style10">GradeLevels:&nbsp;&nbsp; </td><td class="style7">
                    <asp:Literal ID="ltrgl" runat="server" Text="-"></asp:Literal></td>
                   <td class="style9">Year Graduated:&nbsp;&nbsp; </td><td>
                    <asp:Literal 
                        ID="ltrygard" runat="server" Text="-"></asp:Literal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>            
            </tr>
                <tr>
                   <td class="style10">Matchup:&nbsp;&nbsp; </td><td class="style7">
                    <asp:Literal ID="ltrmatch" runat="server" Text="-"></asp:Literal></td>
                   <td class="style9">Major:&nbsp;&nbsp; </td><td>
                    <asp:Literal ID="ltrmajor" runat="server" Text="-"></asp:Literal> </td>            
            </tr>
                <tr>
                   <td class="style10">LearningStyle:&nbsp;&nbsp; </td><td class="style7">
                    <asp:Literal ID="ltrlst" runat="server" Text="-"></asp:Literal></td>
                   <td class="style9">Expertise:&nbsp;&nbsp; </td><td>
                    <asp:Literal ID="ltrexper" runat="server" Text="-"></asp:Literal> </td>            
            </tr>
                <tr>
                   <td class="style10">OtherSkill:&nbsp;&nbsp; </td><td class="style7">
                    <asp:Literal ID="ltros" runat="server" Text="-"></asp:Literal></td>
                   <td class="style9">&nbsp;</td><td>&nbsp;</td>            
            </tr>
            </table>
            </td></tr>
            </table>    
			        </div>
		    </div>
	    </div>    	
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
