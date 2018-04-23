<%--
{************************************************************************************}
{                                                                                    }
{   DO NOT MODIFY THIS FILE!                                                         }
{                                                                                    }
{   It will be overwritten without prompting when a new version becomes              }
{   available. All your changes will be lost.                                        }
{                                                                                    }
{   This file contains the default template and is required for the form             }
{   rendering. Improper modifications may result in incorrect behavior of            }
{   dialog forms.                                                                    }
{                                                                                    }
{************************************************************************************}
--%>
<%@ Control Language="C#" AutoEventWireup="true" CodeFile="InsertImageForm.ascx.cs" Inherits="InsertImageForm" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v9.3, Version=9.3.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.ASPxHtmlEditor.v9.3, Version=9.3.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxHtmlEditor" TagPrefix="dxhe" %>
<%@ Register Assembly="DevExpress.Web.v9.3, Version=9.3.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dxp" %>
<%@ Register Src="ImagePropertiesForm.ascx" TagName="ImagePropertiesForm" TagPrefix="ucip" %>
<dxp:ASPxPanel ID="Panel1" runat="server" Width="100%" DefaultButton="btnInsertImage">
    <PanelCollection>
        <dxp:PanelContent runat="server">
    <table cellpadding="0" cellspacing="0" id="dxInsertImageForm">
        <tr>
            <td class="contentCell">    
                <table cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="typeRadionButtonListCell">
                            <table cellpadding="0" cellspacing="0" class="radioButtonTable">
                                <tr>
                                    <td>
                                        <dxe:ASPxRadioButton ID="rblFromTheWeb" runat="server" GroupName="InsertImageFormGroup" Checked="True" TextWrap="False" ClientInstanceName="_dxeRblImageFromTheWeb">
                                            <ClientSideEvents CheckedChanged="function(s, e) { OnImageFromTypeChanged__InsertImageForm(s); }" />
                                        </dxe:ASPxRadioButton>                                    
                                    </td>
                                    <td>
                                        <dxe:ASPxRadioButton ID="rblFromThisComputer" runat="server" GroupName="InsertImageFormGroup" TextWrap="False" ClientInstanceName="_dxeRblImageFromThisComputer">
                                            <ClientSideEvents CheckedChanged="function(s, e) { OnImageFromTypeChanged__InsertImageForm(s); }" />
                                        </dxe:ASPxRadioButton>                                    
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>        
                    <tr>
                        <td>
                            <table cellpadding="0" cellspacing="0" style="width:100%;">
                                <tr>
                                    <td style="vertical-align:top">
                                        <dxhe:ASPxHtmlEditorRoundPanel ID="rpInsertImage" runat="server" Width="315px">
                                            <PanelCollection>
                                                <dxhe:HtmlEditorRoundPanelContent runat="server">
                                                    <!-- FromTheWeb -->                                                    
                                                    <table cellpadding="0" cellspacing="0" id='<% =HtmlEditor.ClientID + "_dxeFromTheWeb" %>' class="fromTheWeb" >
                                                        <tr>
                                                            <td>
                                                                <dxe:ASPxLabel ID="lblImageUrl" runat="server" AssociatedControlID="txbInsertImageUrl">
                                                                </dxe:ASPxLabel>                            
                                                                <div class="captionIndent"></div>
                                                               <%-- <dxe:ASPxTextBox ID="txbInsertImageUrl" ClientInstanceName="_dxeTbxInsertImageUrl" runat="server" Width="274px" AutoCompleteType="Disabled">
                                                                    <ClientSideEvents TextChanged="function(s, e) { aspxInsertImageSrcValueChanged(s.GetText()); }" />
                                                                    <ValidationSettings ErrorDisplayMode="Text" ErrorTextPosition="Bottom" SetFocusOnError="True" ValidateOnLeave="False" ValidationGroup="_dxeTbxInsertImageUrlGroup">
                                                                        <RequiredField IsRequired="True" />                                                                    
                                                                        <ErrorFrameStyle Font-Size="10px">
                                                                        </ErrorFrameStyle>
                                                                    </ValidationSettings>
                                                                </dxe:ASPxTextBox>--%>
                                                                <dxe:ASPxButtonEdit ID="txbInsertImageUrl" ClientInstanceName="_dxeTbxInsertImageUrl" runat="server" Width="274px" AutoCompleteType="Disabled">
                                                                    <ClientSideEvents TextChanged="function(s, e) { aspxInsertImageSrcValueChanged(s.GetText()); }" />
                                                                    <ValidationSettings ErrorDisplayMode="Text" ErrorTextPosition="Bottom" SetFocusOnError="True" ValidateOnLeave="False" ValidationGroup="_dxeTbxInsertImageUrlGroup">
                                                                        <RequiredField IsRequired="True" />                                                                    
                                                                        <ErrorFrameStyle Font-Size="10px">
                                                                        </ErrorFrameStyle>
                                                                    </ValidationSettings>
                                                                    <Buttons>
                                                                    <dxe:EditButton></dxe:EditButton>
                                                                    </Buttons>
                                                                    <ClientSideEvents ButtonClick="function(s,e){ ShowFileBrowser();}" />
                                                                </dxe:ASPxButtonEdit>

                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="saveToServerCheckBoxCell">
                                                                <dxe:ASPxCheckBox ID="ckbSaveToServer" ClientInstanceName="_dxeCkbSaveToServer" runat="server">
                                                                </dxe:ASPxCheckBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="imagePreview"> 
                                                                <table cellpadding="0" cellspacing="0" style="width: 100%;">
                                                                    <tr>
                                                                        <td class="imagePreviewCell">
                                                                            <span id='<% =HtmlEditor.ClientID + "_dxInsertImagePreviewText" %>'><% =DevExpress.Web.ASPxHtmlEditor.Localization.ASPxHtmlEditorLocalizer.GetString(DevExpress.Web.ASPxHtmlEditor.Localization.ASPxHtmlEditorStringId.InsertImage_Preview)%></span>
                                                                            <img id='<% =HtmlEditor.ClientID + "_dxInsertImagePreviewImage"%>' style="display:none;" width="180" height="100" alt="<% =DevExpress.Web.ASPxHtmlEditor.Localization.ASPxHtmlEditorLocalizer.GetString(DevExpress.Web.ASPxHtmlEditor.Localization.ASPxHtmlEditorStringId.InsertImage_Preview) %>"/>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>                                                    
                                                    <!-- FromThisComputer -->                    
                                                    <table cellpadding="0" cellspacing="0" id='<% =HtmlEditor.ClientID + "_dxeFromThisComputer" %>' style="display: none;">
                                                        <tr>
                                                            <td>
                                                                <dxe:ASPxLabel ID="lblBrowse" runat="server" AssociatedControlID="uplImage">
                                                                </dxe:ASPxLabel>
                                                                <div class="captionIndent"></div>
                                                                <%--  Since the client FileUploadComplete event is not generated if the length of a request (the size of a file to upload) exceeds the maximum allowed request length, we duplicate a call to the aspxImageUploadComplete method within the FilesUploadComplete event handler.
                                                                      This is required to switch the Insert Image dialog to its active state (to remove the Loading Div element).  --%>
                                                                <dxhe:ASPxHtmlEditorUploadControl ID="uplImage" runat="server" ClientInstanceName="_dxeUplImage"
                                                                    OnFileUploadComplete="uplImage_FileUploadComplete">
                                                                    <ClientSideEvents FileUploadComplete="function(s, e) { aspxImageUploadComplete(e); }" FilesUploadComplete="function(s, e) { aspxImageUploadComplete(e); }"
                                                                     TextChanged="function(s, e) { aspxImageUploadTextChanged(); }" FileUploadStart="function(s, e) { aspxImageUploadStart(); }"/>
                                                                </dxhe:ASPxHtmlEditorUploadControl>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </dxhe:HtmlEditorRoundPanelContent>
                                            </PanelCollection>
                                        </dxhe:ASPxHtmlEditorRoundPanel>                                        
                                    </td>
                                    <%-- Image Properties --%>                                    
                                    <td id='<% =HtmlEditor.ClientID + "_dxeMoreImagePropertiesRow"%>' class="imagePropertiesCell" style="display:none">
                                        <ucip:ImagePropertiesForm ID="ucImagePropertiesForm" runat="server" />                            
                                    </td>                            
                                </tr>
                            </table>                                                
                        </td>
                    </tr>
                    <tr>
                        <td class="moreOptionsCell">
                            <dxe:ASPxCheckBox ID="ckbMoreImageOptions" ClientInstanceName="_dxeCkbMoreImageOptions" runat="server">
                                <ClientSideEvents CheckedChanged="function(s, e) { OnMoreImageOptionsCheckedChanged(s.GetChecked()) }" />                    
                            </dxe:ASPxCheckBox>            
                        </td>
                    </tr>
                </table>                            
            </td>        
        </tr>
        <tr>
            <%-- Button Cells --%>
            <td class="buttonsCell" align="right">
                <table cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <dxe:ASPxButton ID="btnInsertImage" runat="server" Height="26px" Width="82px"
                                Autopostback="false" ClientInstanceName="_dxeBtnInsertImage" CausesValidation="False" >
                                <clientsideevents click="function(s, e) { OnOkButtonClick_InsertImageForm(); }" />
                            </dxe:ASPxButton>
                            <dxe:ASPxButton ID="btnChangeImage" runat="server" AutoPostBack="False" Height="23px"
                                Width="74px" ClientInstanceName="_dxeBtnChangeImage" ClientVisible="False" CausesValidation="False">
                                <clientsideevents click="function(s, e) { OnOkButtonClick_InsertImageForm(); }" />
                            </dxe:ASPxButton>
                        </td>
                        <td class="cancelButton">
                            <dxe:ASPxButton ID="btnInsertImageCancel" runat="server" Height="26px"
                                Width="82px" Autopostback="false" CausesValidation="False">
                                <clientsideevents click="function(s, e) { OnCancelButtonClick_InsertImageForm(); }" />
                            </dxe:ASPxButton>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
         </dxp:PanelContent>
    </PanelCollection>
</dxp:ASPxPanel>
<script type="text/javascript" id="dxss_InsertLinkForm">
    function GetDialogData_InsertImageForm() {
        var res = new Object();
        res.width = null;
        res.height = null;
        
        res.src = _dxeTbxInsertImageUrl.GetText();
        var isOriginal = _dxeCmbSize.GetValue().toLowerCase() == "original";
        if (!isOriginal)
            res.width = _dxeSpnWidth.GetValue();
        if (!isOriginal)
            res.height = _dxeSpnHeight.GetValue();
        res.align = _dxeCmbImagePosition.GetValue();
        res.alt = _dxeTxbDescription.GetText();
        res.useFloat = _dxeCkbWrapTextArroundImage.GetChecked();
        return res;
    }
    function IsValidFields_InsertImageForm() {
        var ret = true;
        if (_dxeTbxInsertImageUrl.IsVisible())
            ret = ASPxClientEdit.ValidateGroup("_dxeTbxInsertImageUrlGroup") && ret;
        else 
            ret = (_dxeUplImage.GetText() != "") && ret;
            
        if (_dxeCkbCreateThumbnail.GetChecked())
            ret = ASPxClientEdit.ValidateGroup("_dxeThumbnailFileNameGroup") && ret;
        return ret;
    }
    function OnOkButtonClick_InsertImageForm() {
        if (IsValidFields_InsertImageForm())        
            aspxDialogComplete(1, GetDialogData_InsertImageForm());
    }
    function OnCancelButtonClick_InsertImageForm() {
        aspxDialogComplete(0, GetDialogData_InsertImageForm());
    }
    function OnMoreImageOptionsCheckedChanged(isChecked) {
        _aspxSetElementDisplay(_aspxGetElementById('<% =HtmlEditor.ClientID + "_dxeMoreImagePropertiesRow"%>'), isChecked);
        if (isChecked)
            aspxAdjustControlsSizeInDialogWindow();
    }        
    function OnImageFromTypeChanged__InsertImageForm() {
        var fromWebArea = _aspxGetElementById('<% =HtmlEditor.ClientID + "_dxeFromTheWeb" %>');
        var fromThisComputerArea = _aspxGetElementById('<% =HtmlEditor.ClientID + "_dxeFromThisComputer" %>');
        _aspxSetElementDisplay(fromWebArea, _dxeRblImageFromTheWeb.GetChecked());
        _aspxSetElementDisplay(fromThisComputerArea, _dxeRblImageFromThisComputer.GetChecked());
        aspxOnImageFromTypeChanged();
    }
</script>