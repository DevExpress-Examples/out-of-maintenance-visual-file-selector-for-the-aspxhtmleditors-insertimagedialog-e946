/*
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
*/
using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using DevExpress.Web.ASPxHtmlEditor;
using DevExpress.Web.ASPxHtmlEditor.Localization;
using DevExpress.Web.ASPxClasses;
using DevExpress.Web.ASPxEditors;
using DevExpress.Web.ASPxClasses.Internal;

public partial class ImagePropertiesForm : HtmlEditorUserControl {
    protected void Page_Load(object sender, EventArgs e) {
        ckbCreateThumbnail.ClientVisible = !string.IsNullOrEmpty(HtmlEditor.SettingsImageUpload.UploadImageFolder);
        CreateConstrainProportionsImages();
        Localize();
    }
    void Localize() {
        lblSize.Text = ASPxHtmlEditorLocalizer.GetString(ASPxHtmlEditorStringId.ImageProps_Size) + ":";
        cmbSize.Items.Add(ASPxHtmlEditorLocalizer.GetString(ASPxHtmlEditorStringId.ImageProps_OriginalSize), "original");
        cmbSize.Items.Add(ASPxHtmlEditorLocalizer.GetString(ASPxHtmlEditorStringId.ImageProps_CustomSize), "custom");
        cmbSize.SelectedIndex = 0;
        lblWidth.Text = ASPxHtmlEditorLocalizer.GetString(ASPxHtmlEditorStringId.ImageProps_Width) + ":";
        lblPixelWidth.Text = ASPxHtmlEditorLocalizer.GetString(ASPxHtmlEditorStringId.ImageProps_Pixels);
        lblHeight.Text = ASPxHtmlEditorLocalizer.GetString(ASPxHtmlEditorStringId.ImageProps_Height) + ":";
        lblPixelHeight.Text = ASPxHtmlEditorLocalizer.GetString(ASPxHtmlEditorStringId.ImageProps_Pixels);
        ckbCreateThumbnail.Text = ASPxHtmlEditorLocalizer.GetString(ASPxHtmlEditorStringId.ImageProps_CreateThumbnail);
        lblThumbnailFileName.Text = ASPxHtmlEditorLocalizer.GetString(ASPxHtmlEditorStringId.ImageProps_NewImageName) + ":";
        txbThumbnailFileName.ValidationSettings.RequiredField.ErrorText = ASPxHtmlEditorLocalizer.GetString(ASPxHtmlEditorStringId.RequiredFieldError);
        lblImagePosition.Text = ASPxHtmlEditorLocalizer.GetString(ASPxHtmlEditorStringId.ImageProps_Position) + ":";
        cmbImagePosition.Items.Add(ASPxHtmlEditorLocalizer.GetString(ASPxHtmlEditorStringId.ImageProps_PositionLeft), "left");
        cmbImagePosition.Items.Add(ASPxHtmlEditorLocalizer.GetString(ASPxHtmlEditorStringId.ImageProps_PositionCenter), "center");
        cmbImagePosition.Items.Add(ASPxHtmlEditorLocalizer.GetString(ASPxHtmlEditorStringId.ImageProps_PositionRight), "right");
        cmbImagePosition.SelectedIndex = 0;
        lblImageDescription.Text = ASPxHtmlEditorLocalizer.GetString(ASPxHtmlEditorStringId.ImageProps_Description) + ":";
        ckbWrapTextArroundImage.Text = ASPxHtmlEditorLocalizer.GetString(ASPxHtmlEditorStringId.InsertImage_UseFloat);
    }
    protected override ASPxEditBase[] GetChildDxEdits() {
        return new ASPxEditBase[] {lblSize, cmbSize,
                lblWidth,  spnWidth, 
                lblPixelWidth, lblHeight, 
                spnHeight, lblPixelHeight, lblImagePosition,
                cmbImagePosition, lblImageDescription,
                txbDescription, ckbCreateThumbnail, lblThumbnailFileName, txbThumbnailFileName,
                ckbWrapTextArroundImage
                };
    }
    protected void CreateConstrainProportionsImages() {
        Image imgTop = RenderUtils.CreateImage();
        cellContarainTop.Controls.Add(imgTop);
        HtmlEditor.GetInsertImageDialogConstrainProportionsTop().AssignToControl(imgTop, false);

        Image imgBottom = RenderUtils.CreateImage();
        cellContarainBottom.Controls.Add(imgBottom);
        HtmlEditor.GetInsertImageDialogConstrainProportionsBottom().AssignToControl(imgBottom, false);

        Image imgSwitcherOn = RenderUtils.CreateImage();
        imgSwitcherOn.ID = "imgOn";
        cellContarainSwitcher.Controls.Add(imgSwitcherOn);
        HtmlEditor.GetInsertImageDialogConstrainProportionsMiddleOn().AssignToControl(imgSwitcherOn, false);

        Image imgSwitcherOff = RenderUtils.CreateImage();
        imgSwitcherOff.ID = "imgOff";
        cellContarainSwitcher.Controls.Add(imgSwitcherOff);
        HtmlEditor.GetInsertImageDialogConstrainProportionsMiddleOff().AssignToControl(imgSwitcherOff, false);

        imgSwitcherOn.Attributes.Add("onclick", "aspxConstrainProportionsSwitchClick(event, '" + imgSwitcherOff.ClientID + "')");
        imgSwitcherOff.Attributes.Add("onclick", "aspxConstrainProportionsSwitchClick(event,'" + imgSwitcherOn.ClientID + "')");
        imgSwitcherOff.Style.Add("display", "none");
    }
}
