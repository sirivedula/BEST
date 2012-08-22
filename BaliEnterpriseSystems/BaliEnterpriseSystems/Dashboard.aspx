<%@ Page Language="C#" MasterPageFile="~/Best.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="BaliEnterpriseSystems.Dashboard" Title="BEST - Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style type="text/css">
    .divForm4 { border-top:5px solid #884a0a; background-color:#fff;width:100%; font-family:Tahoma; font-size:small;}
    .divBox {border:1px solid #884a0a;text-align:center;padding:1px;font-weight:bold;color:#FFF;border-top-left-radius:4px;border-top-right-radius:4px; background-color:#884a0a}
    .tblpersonal { background-color:#f1e9dc; width:100%; padding:1px; border-left:1px solid #884a0a; border-right:1px solid #884a0a;border-bottom:1px solid #884a0a; }
    .tbllogins { width:100%; background-color:#f1e9dc; padding:1px; border-left:1px solid #884a0a; border-right:1px solid #884a0a;border-bottom:1px solid #884a0a; }
    .tbllogins tr th { background-color: #FFF; font-weight:bold; }
    .trordd td { background-color: #fff; }             
</style>
    <script type="text/javascript">
        function sendMessage() {
            var msgTo = $('#messageTo').val();
            var msg = $('#message').val();
            if (msgTo.length == 0) {
                alert('Select Message To');
                return false;
            }
            if (msg.length == 0) {
                alert('Write Message');
                return false;
            }
            var params = {};
            params.msgTo = msgTo;
            params.msgText = msg;
            $.post("SaveSendMessage.aspx", params, function(data) {
                $('#messageTo').val('');
                $('#message').val('');
                $('#divMessage').html(data);
            });
        }
        
    </script>
<asp:Literal ID="ltrMScript" runat="server">
</asp:Literal>    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="divForm4">
        <table style="width:100%;">
        <tr><td style="vertical-align:top;width:50%;"><div class="divBox">Personal</div><div><asp:Literal ID="ltrPersonal" runat="server"></asp:Literal></div></td>
            <td style="vertical-align:top;width:50%;"><div class="divBox">Messages</div><div><asp:Literal ID="ltrMessage" runat="server"></asp:Literal></div></td></tr>
            <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
        <tr><td style="vertical-align:top;width:50%;"><div class="divBox">Schedules</div><div><asp:Literal ID="ltrSchedule" runat="server"></asp:Literal></div></td>
            <td style="vertical-align:top;width:50%;"><div class="divBox">Communications</div><div><asp:Literal ID="ltrCommunication" runat="server"></asp:Literal></div></td></tr>
        </table>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
