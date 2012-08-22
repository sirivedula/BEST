<%@ Page Language="C#" MasterPageFile="~/Best.Master" AutoEventWireup="true" CodeBehind="UserRolesInfo.aspx.cs" Inherits="BaliEnterpriseSystems.UserRolesInfo" Title="BEST - User Roles"  EnableViewState="false" EnableEventValidation="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<script type="text/javascript">
    function doSave(){
        $('#saveClicked').val("1");
        submit();
    }
</script>
<asp:Literal ID="ltrMScript" runat="server">
</asp:Literal>
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
<div class="centered"><table><tr><td>User Name</td><td><input type="hidden" id="saveClicked" name="saveClicked" /><select id="username" name="username" onchange="submit();">
                    <asp:Literal ID="ltrSelectUser" runat="server"></asp:Literal></select></td></tr></table>
                    <asp:Literal ID="ltrGrid" runat="server"></asp:Literal></div>
                </div>
		    </div>
	    </div>    	
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
