<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.ASPxHtmlEditor.v9.3" Namespace="DevExpress.Web.ASPxHtmlEditor"
    TagPrefix="dxhe" %>
<%@ Register Assembly="DevExpress.Web.ASPxSpellChecker.v9.3" Namespace="DevExpress.Web.ASPxSpellChecker"
    TagPrefix="dxwsc" %>
<%@ Register Assembly="DevExpress.Web.v9.3" Namespace="DevExpress.Web.ASPxPopupControl"
    TagPrefix="dxpc" %>
<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v9.3" Namespace="DevExpress.Web.ASPxTreeList"
    TagPrefix="dxwtl" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v9.3" Namespace="DevExpress.Web.ASPxEditors"
    TagPrefix="dxe" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    <style type="text/css">
        body
        {
            font-family: Tahoma;
            font-size: 9pt;
            color: #111;
        }
    </style>

    <script language="javascript">
        var PreviewCommand = "Preview";
        var ChooseCommand = "Choose";
        var InitCommand = "Init";

        function ShowFileBrowser() {
            tlBrowser.SetFocusedNodeKey(tlBrowser.cpFirstNodeKey);
            ShowPreviewImageCallback(tlBrowser.cpFirstNodeUrl);
            pcBrowser.Show();
        }
        function ShowPreviewImage(treeList) {

            var key = treeList.GetFocusedNodeKey();
            if (treeList.GetNodeState(key) == "Child")
                treeList.PerformCustomDataCallback(PreviewCommand + "~" + key);
            else
                imgPreview.SetImageUrl(treeList.cpFolderUrl);
        }
        function ShowPreviewImageCallback(url) {
            imgPreview.SetImageUrl(url);
        }
        function OKClick(treeList) {
            var key = treeList.GetFocusedNodeKey();
            var nodeState = treeList.GetNodeState(key);
            if (nodeState != "Child") {
                if (nodeState == "Expanded")
                    treeList.CollapseNode(key);
                else
                    treeList.ExpandNode(key);
            }
            else {
                pcBrowser.Hide();
                treeList.PerformCustomDataCallback(ChooseCommand + "~" + key);
            }
        }
        function OKClickCallback(url) {
            _dxeTbxInsertImageUrl.SetText(url);
            aspxInsertImageSrcValueChanged(url);
        }
        function ExecuteDataCallback(result) {
            var parameters = result.split("~");
            if (parameters.length >= 2) {
                switch (parameters[0]) {
                    case PreviewCommand:
                        ShowPreviewImageCallback(parameters[1]);
                        break;
                    case ChooseCommand:
                        OKClickCallback(parameters[1]);
                        break;
                }
            }
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div>
        Invoke the 'Insert Image' dialog and click the ellipsis button within the 'Enter
        image web address' editor.
    </div>
    <br />
    <div>
        <dxpc:ASPxPopupControl ID="pcBrowser" runat="server" HeaderText="Browse" Width="720px"
            AllowDragging="True" Modal="True" EnableAnimation="False" PopupHorizontalAlign="WindowCenter"
            PopupVerticalAlign="WindowCenter" ClientInstanceName="pcBrowser">
            <ContentCollection>
                <dxpc:PopupControlContentControl runat="server">
                    <table cellspacing="4" cellpadding="0" border="0" style="width: 100%">
                        <tr>
                            <td style="border-right: #7f7f7f 1px solid; border-top: #7f7f7f 1px solid; border-left: #7f7f7f 1px solid;
                                border-bottom: #7f7f7f 1px solid;">
                                <div style="height: 300px; overflow: auto;">
                                    <dxwtl:ASPxTreeList ID="tlBrowser" runat="server" Width="400px" OnVirtualModeCreateChildren="treeList_VirtualModeCreateChildren"
                                        OnVirtualModeNodeCreating="treeList_VirtualModeNodeCreating" AutoGenerateColumns="False"
                                        ClientInstanceName="tlBrowser" OnCustomDataCallback="tlBrowser_CustomDataCallback"
                                        OnCustomJSProperties="tlBrowser_CustomJSProperties">
                                        <Columns>
                                            <dxwtl:TreeListTextColumn FieldName="name" Caption="File name" VisibleIndex="0" />
                                            <dxwtl:TreeListTextColumn FieldName="date" Caption="Creation Date" Width="10%" VisibleIndex="1">
                                                <PropertiesTextEdit DisplayFormatString="{0:g}">
                                                </PropertiesTextEdit>
                                            </dxwtl:TreeListTextColumn>
                                        </Columns>
                                        <SettingsBehavior ExpandCollapseAction="NodeDblClick" AllowFocusedNode="True" />
                                        <Settings ShowColumnHeaders="False" />
                                        <ClientSideEvents FocusedNodeChanged="function(s, e) {
	ShowPreviewImage(s);	
}" CustomDataCallback="function(s, e) {
	ExecuteDataCallback(e.result);
}" />
                                    </dxwtl:ASPxTreeList>
                                </div>
                            </td>
                            <td style="border-right: #7f7f7f 1px solid; border-top: #7f7f7f 1px solid; border-left: #7f7f7f 1px solid;
                                border-bottom: #7f7f7f 1px solid; width: 250px" align="center">
                                <dxe:ASPxImage ID="imgPreview" runat="server" ClientInstanceName="imgPreview">
                                </dxe:ASPxImage>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" colspan="2" style="padding-top: 8px;">
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <dxe:ASPxButton ID="btnOk" runat="server" Text="Ok" Width="74px" AutoPostBack="False">
                                                <ClientSideEvents Click="function(s, e) {
	OKClick(tlBrowser);
}" />
                                            </dxe:ASPxButton>
                                        </td>
                                        <td style="width: 4px;">
                                        </td>
                                        <td>
                                            <dxe:ASPxButton ID="btnCancel" runat="server" Text="Cancel" Width="74px" AutoPostBack="False">
                                                <ClientSideEvents Click="function(s, e) {
	pcBrowser.Hide();
}" />
                                            </dxe:ASPxButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </dxpc:PopupControlContentControl>
            </ContentCollection>
        </dxpc:ASPxPopupControl>
        <dxhe:ASPxHtmlEditor ID="ASPxHtmlEditor1" runat="server">
            <SettingsImageUpload>
                <ValidationSettings AllowedContentTypes="image/jpeg,image/pjpeg,image/gif,image/png,image/x-png">
                </ValidationSettings>
            </SettingsImageUpload>
            <Toolbars>
                <dxhe:StandardToolbar1 Caption="Standard1" Name="Standard1">
                    <Items>
                        <dxhe:ToolbarCutButton>
                        </dxhe:ToolbarCutButton>
                        <dxhe:ToolbarCopyButton>
                        </dxhe:ToolbarCopyButton>
                        <dxhe:ToolbarPasteButton>
                        </dxhe:ToolbarPasteButton>
                        <dxhe:ToolbarPasteFromWordButton>
                        </dxhe:ToolbarPasteFromWordButton>
                        <dxhe:ToolbarUndoButton BeginGroup="True">
                        </dxhe:ToolbarUndoButton>
                        <dxhe:ToolbarRedoButton>
                        </dxhe:ToolbarRedoButton>
                        <dxhe:ToolbarRemoveFormatButton BeginGroup="True">
                        </dxhe:ToolbarRemoveFormatButton>
                        <dxhe:ToolbarSuperscriptButton BeginGroup="True">
                        </dxhe:ToolbarSuperscriptButton>
                        <dxhe:ToolbarSubscriptButton>
                        </dxhe:ToolbarSubscriptButton>
                        <dxhe:ToolbarInsertOrderedListButton BeginGroup="True">
                        </dxhe:ToolbarInsertOrderedListButton>
                        <dxhe:ToolbarInsertUnorderedListButton>
                        </dxhe:ToolbarInsertUnorderedListButton>
                        <dxhe:ToolbarIndentButton BeginGroup="True">
                        </dxhe:ToolbarIndentButton>
                        <dxhe:ToolbarOutdentButton>
                        </dxhe:ToolbarOutdentButton>
                        <dxhe:ToolbarInsertLinkDialogButton BeginGroup="True">
                        </dxhe:ToolbarInsertLinkDialogButton>
                        <dxhe:ToolbarUnlinkButton>
                        </dxhe:ToolbarUnlinkButton>
                        <dxhe:ToolbarInsertImageDialogButton Text="Insert Image" ViewStyle="ImageAndText" >
                        </dxhe:ToolbarInsertImageDialogButton>
                        <dxhe:ToolbarCheckSpellingButton BeginGroup="True">
                        </dxhe:ToolbarCheckSpellingButton>
                        <dxhe:ToolbarTableOperationsDropDownButton BeginGroup="True">
                            <Items>
                                <dxhe:ToolbarInsertTableDialogButton BeginGroup="True" ViewStyle="ImageAndText">
                                </dxhe:ToolbarInsertTableDialogButton>
                                <dxhe:ToolbarTablePropertiesDialogButton BeginGroup="True">
                                </dxhe:ToolbarTablePropertiesDialogButton>
                                <dxhe:ToolbarTableRowPropertiesDialogButton>
                                </dxhe:ToolbarTableRowPropertiesDialogButton>
                                <dxhe:ToolbarTableColumnPropertiesDialogButton>
                                </dxhe:ToolbarTableColumnPropertiesDialogButton>
                                <dxhe:ToolbarTableCellPropertiesDialogButton>
                                </dxhe:ToolbarTableCellPropertiesDialogButton>
                                <dxhe:ToolbarInsertTableRowAboveButton BeginGroup="True">
                                </dxhe:ToolbarInsertTableRowAboveButton>
                                <dxhe:ToolbarInsertTableRowBelowButton>
                                </dxhe:ToolbarInsertTableRowBelowButton>
                                <dxhe:ToolbarInsertTableColumnToLeftButton>
                                </dxhe:ToolbarInsertTableColumnToLeftButton>
                                <dxhe:ToolbarInsertTableColumnToRightButton>
                                </dxhe:ToolbarInsertTableColumnToRightButton>
                                <dxhe:ToolbarSplitTableCellHorizontallyButton BeginGroup="True">
                                </dxhe:ToolbarSplitTableCellHorizontallyButton>
                                <dxhe:ToolbarSplitTableCellVerticallyButton>
                                </dxhe:ToolbarSplitTableCellVerticallyButton>
                                <dxhe:ToolbarMergeTableCellRightButton>
                                </dxhe:ToolbarMergeTableCellRightButton>
                                <dxhe:ToolbarMergeTableCellDownButton>
                                </dxhe:ToolbarMergeTableCellDownButton>
                                <dxhe:ToolbarDeleteTableButton BeginGroup="True">
                                </dxhe:ToolbarDeleteTableButton>
                                <dxhe:ToolbarDeleteTableRowButton>
                                </dxhe:ToolbarDeleteTableRowButton>
                                <dxhe:ToolbarDeleteTableColumnButton>
                                </dxhe:ToolbarDeleteTableColumnButton>
                            </Items>
                        </dxhe:ToolbarTableOperationsDropDownButton>
                    </Items>
                </dxhe:StandardToolbar1>
                <dxhe:StandardToolbar2 Name="Standard2">
                    <Items>
                        <dxhe:ToolbarFontNameEdit>
                            <Items>
                                <dxhe:ToolbarListEditItem Text="Times New Roman" Value="Times New Roman"></dxhe:ToolbarListEditItem>
                                <dxhe:ToolbarListEditItem Text="Tahoma" Value="Tahoma"></dxhe:ToolbarListEditItem>
                                <dxhe:ToolbarListEditItem Text="Verdana" Value="Verdana"></dxhe:ToolbarListEditItem>
                                <dxhe:ToolbarListEditItem Text="Arial" Value="Arial"></dxhe:ToolbarListEditItem>
                                <dxhe:ToolbarListEditItem Text="MS Sans Serif" Value="MS Sans Serif"></dxhe:ToolbarListEditItem>
                                <dxhe:ToolbarListEditItem Text="Courier" Value="Courier"></dxhe:ToolbarListEditItem>
                            </Items>
                        </dxhe:ToolbarFontNameEdit>
                        <dxhe:ToolbarFontSizeEdit>
                            <Items>
                                <dxhe:ToolbarListEditItem Text="1 (8pt)" Value="1"></dxhe:ToolbarListEditItem>
                                <dxhe:ToolbarListEditItem Text="2 (10pt)" Value="2"></dxhe:ToolbarListEditItem>
                                <dxhe:ToolbarListEditItem Text="3 (12pt)" Value="3"></dxhe:ToolbarListEditItem>
                                <dxhe:ToolbarListEditItem Text="4 (14pt)" Value="4"></dxhe:ToolbarListEditItem>
                                <dxhe:ToolbarListEditItem Text="5 (18pt)" Value="5"></dxhe:ToolbarListEditItem>
                                <dxhe:ToolbarListEditItem Text="6 (24pt)" Value="6"></dxhe:ToolbarListEditItem>
                                <dxhe:ToolbarListEditItem Text="7 (36pt)" Value="7"></dxhe:ToolbarListEditItem>
                            </Items>
                        </dxhe:ToolbarFontSizeEdit>
                        <dxhe:ToolbarBoldButton BeginGroup="True">
                        </dxhe:ToolbarBoldButton>
                        <dxhe:ToolbarItalicButton>
                        </dxhe:ToolbarItalicButton>
                        <dxhe:ToolbarUnderlineButton>
                        </dxhe:ToolbarUnderlineButton>
                        <dxhe:ToolbarStrikethroughButton>
                        </dxhe:ToolbarStrikethroughButton>
                        <dxhe:ToolbarJustifyLeftButton BeginGroup="True">
                        </dxhe:ToolbarJustifyLeftButton>
                        <dxhe:ToolbarJustifyCenterButton>
                        </dxhe:ToolbarJustifyCenterButton>
                        <dxhe:ToolbarJustifyRightButton>
                        </dxhe:ToolbarJustifyRightButton>
                        <dxhe:ToolbarJustifyFullButton>
                        </dxhe:ToolbarJustifyFullButton>
                        <dxhe:ToolbarBackColorButton BeginGroup="True" Text="BackColor" ToolTip="Back Color">
                        </dxhe:ToolbarBackColorButton>
                        <dxhe:ToolbarFontColorButton Text="ForeColor" ToolTip="Fore Color">
                        </dxhe:ToolbarFontColorButton>
                    </Items>
                </dxhe:StandardToolbar2>
            </Toolbars>
        </dxhe:ASPxHtmlEditor>
    </div>
    </form>
</body>
</html>
