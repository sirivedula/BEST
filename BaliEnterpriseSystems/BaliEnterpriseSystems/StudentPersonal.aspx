<%@ Page Title="BEST - Student Information" Language="C#" MasterPageFile="~/Best.Master" AutoEventWireup="true" CodeBehind="StudentPersonal.aspx.cs" Inherits="BaliEnterpriseSystems.StudentPersonal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style type="text/css">
</style>

<asp:Literal ID="ltrMScript" runat="server">
</asp:Literal>
<asp:Literal ID="ltrScript" runat="server"></asp:Literal>

    <script language="javascript" type="text/javascript">
// <!CDATA[

        function parentemail_onclick() {

        }

// ]]>
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
				<table cellpadding="0" cellspacing="0" style="padding-top:10px; width: 80%;" align="center">
<!-- Student Information -->
				<tr><td>&nbsp;Student Infomation</td></tr>
				<tr><td>
					<table style="border:1px solid #884a0a;width:100%; background-color:#EEE;">
					<tr><td colspan="4">
						<table style="border:1px solid #884a0a;width:100%;background-color:#EEE;">
							<tr><td align="center">Picture
							<div style="height:100px;width:100px;border:1px solid #999;" 
									align="center"><asp:Literal ID="photoDisplay" runat="server"></asp:Literal></div>
									<asp:Literal ID="ltrPhoto" runat="server"></asp:Literal></td>
							</tr>
						</table>  
					</td></tr>
					<tr>                
						<td>Center Id:</td><td><asp:Literal ID="ltrcid" runat="server" Text="-"></asp:Literal></td>
						<td>Student Id: </td><td><asp:Literal ID="ltrsid" runat="server" Text="-"></asp:Literal></td>
					</tr>
					<tr>
						<td>First Name: </td><td><asp:Literal ID="ltrfname" runat="server" Text="-"></asp:Literal></td>            
						<td>Last Name: </td><td><asp:Literal ID="ltrlname" runat="server" Text="-"></asp:Literal></td>
					</tr>            
					<tr>
						<td>Middle Name: </td><td><asp:Literal ID="ltrmidname" runat="server" Text="-"></asp:Literal></td>
						<td>Parent Name: </td><td><asp:Literal ID="ltrpname" runat="server" Text="-"></asp:Literal></td>
					</tr>            
					<tr>
						<td>Joining Date: </td><td><asp:Literal ID="ltrjoindate" runat="server" Text="-"></asp:Literal></td>
						<td>Birth Date: </td><td><asp:Literal ID="ltrbdate" runat="server" Text="-"></asp:Literal></td>
					</tr>            
					<tr>
						<td>Address 1: </td><td><asp:Literal ID="ltradd1" runat="server" Text="-"></asp:Literal></td>
						<td>Address 2: </td><td><asp:Literal ID="ltradd2" runat="server" Text="-"></asp:Literal></td>
					</tr>            
					<tr>
						<td>City: </td><td><asp:Literal ID="ltrcity" runat="server" Text="-"></asp:Literal></td>
						<td>State: </td><td><asp:Literal ID="ltrstate" runat="server" Text="-"></asp:Literal></td></tr>            
					<tr>
						<td>Zip: </td><td><asp:Literal ID="ltrzip" runat="server" Text="-"></asp:Literal></td>
						<td>Cell Phone: </td><td><asp:Literal ID="ltrcell" runat="server" Text="-"></asp:Literal></td>
					</tr>            
					<tr>
						<td>Work Phone: </td><td><asp:Literal ID="ltrwph" runat="server" Text="-"></asp:Literal></td>
						<td>Home Phone: </td><td><asp:Literal ID="ltrhomep" runat="server" Text="-"></asp:Literal></td>
					</tr>            
					<tr>
						<td>Student E-Mail: </td><td><asp:Literal ID="ltremail" runat="server" Text="-"></asp:Literal></td>            
						<td>Guardian's Name: </td><td><asp:Literal ID="ltrgard" runat="server" Text="-"></asp:Literal></td>
					</tr>
					<tr>
					   <td>Hours: </td><td><asp:Literal ID="ltrhr" runat="server" Text="-"></asp:Literal></td>
					   <td>Hours Type: </td><td><asp:Literal ID="ltrhrtype" runat="server" Text="-"></asp:Literal></td>            
					</tr>
					<tr>
					   <td>Gender: </td><td><asp:Literal ID="ltrgender" runat="server" Text="-"></asp:Literal></td>
					   <td>Amount: </td><td><asp:Literal ID="ltramount" runat="server" Text="-"></asp:Literal></td>            
					</tr>
					</table>
				</td></tr>
<!-- Program Information -->
					<tr><td>&nbsp;Program Information</td></tr>
					<tr><td><asp:Literal id="ltrProgram" runat="server"></asp:Literal></td></tr>
<!-- Payment Information -->
					
				</table>    
			    </div>
		    </div>
	    </div>    	
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
