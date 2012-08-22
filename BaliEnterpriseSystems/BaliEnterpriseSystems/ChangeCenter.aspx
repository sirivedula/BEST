<%@ Page Title="" Language="C#" MasterPageFile="~/Best.Master" AutoEventWireup="true" CodeBehind="ChangeCenter.aspx.cs" Inherits="BaliEnterpriseSystems.changeCenter" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
			        <div class="CAreaDiv">Change Center:
                            <table><tr><td>Select Center</td><td><select id="centerid" name="centerid"><asp:Literal ID="ltrCenters" runat="server"></asp:Literal></select></td></tr>
        <tr><td colspan="2"><input type="submit" id="btnSubmit" value="Open" /></td></tr>
        </table>

			        </div>
		    </div>
	    </div>    	
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
