Imports Microsoft.VisualBasic
Imports System
Imports System.Data
Imports System.Configuration
Imports System.Collections
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls
Imports DevExpress.Web.ASPxTreeList
Imports System.Collections.Generic
Imports System.IO

Partial Public Class _Default
	Inherits System.Web.UI.Page
	Public Const ImagesFolder As String = "UploadImages"
	Public Const FolderImageUrl As String = "Images/Folder.png"

	Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

	End Sub
	Protected Sub treeList_VirtualModeCreateChildren(ByVal sender As Object, ByVal e As TreeListVirtualModeCreateChildrenEventArgs)
        Dim path As String
        If (e.NodeObject Is Nothing) Then
            path = Page.MapPath("~/" & ImagesFolder & "/")
        Else
            path = e.NodeObject.ToString()
        End If

        Dim children As List(Of String) = New List(Of String)()
        If Directory.Exists(path) Then
            For Each name As String In Directory.GetDirectories(path)
                children.Add(name)
            Next name
            For Each name As String In Directory.GetFiles(path)
                If IsImageFile(name) Then
                    children.Add(name)
                End If
            Next name
        End If
        e.Children = children
    End Sub

	Protected Sub treeList_VirtualModeNodeCreating(ByVal sender As Object, ByVal e As TreeListVirtualModeNodeCreatingEventArgs)
		Dim nodePath As String = e.NodeObject.ToString()
		e.NodeKeyValue = GetNodeGuid(nodePath)
		e.IsLeaf = Not Directory.Exists(nodePath)
		e.SetNodeValue("name", Path.GetFileName(nodePath))
        e.SetNodeValue("date", Directory.GetCreationTime(nodePath))
        If (Directory.Exists(nodePath)) Then
            e.SetNodeValue("url", FolderImageUrl)
        Else
            e.SetNodeValue("url", GetNodeUrl(nodePath))
        End If
	End Sub


	Private Function GetNodeGuid(ByVal path As String) As Guid
		If (Not Map.ContainsKey(path)) Then
			Map(path) = Guid.NewGuid()
		End If
		Return Map(path)
	End Function
	Private ReadOnly Property Map() As Dictionary(Of String, Guid)
		Get
			Const key As String = "DX_PATH_GUID_MAP"
			If Session(key) Is Nothing Then
				Session(key) = New Dictionary(Of String, Guid)()
			End If
				Return TryCast(Session(key), Dictionary(Of String, Guid))
		End Get
	End Property
	Private Function IsImageFile(ByVal name As String) As Boolean
		Dim extension As String = Path.GetExtension(name).ToLower()
		Return extension = ".png" OrElse extension = ".gif" OrElse extension = ".jpg" OrElse extension = ".jpeg"
	End Function
	Protected Sub tlBrowser_CustomDataCallback(ByVal sender As Object, ByVal e As TreeListCustomDataCallbackEventArgs)
		Dim parameters() As String = e.Argument.Split(New String() { "~" }, StringSplitOptions.None)
		If parameters.Length = 2 Then
			Dim node As TreeListNode = tlBrowser.FindNodeByKeyValue(parameters(1))
			If node IsNot Nothing Then
				e.Result = parameters(0) & "~" & node.GetValue("url")
			End If
		End If
	End Sub
	Protected Sub tlBrowser_CustomJSProperties(ByVal sender As Object, ByVal e As TreeListCustomJSPropertiesEventArgs)
		Dim node As TreeListNode = GetFirstNode()
		If node IsNot Nothing Then
			e.Properties("cpFirstNodeKey") = node.Key
			e.Properties("cpFirstNodeUrl") = node.GetValue("url")
		End If
		e.Properties("cpFolderUrl") = FolderImageUrl
	End Sub
	Private Function GetNodeUrl(ByVal path As String) As String
		Dim url As String = path
		Dim pos As Integer = url.IndexOf(ImagesFolder)
		If pos > -1 Then
			url = url.Substring(pos)
			url = url.Replace("\", "/")
		End If
		Return url
	End Function
    Private Function GetFirstNode() As TreeListNode
        If (tlBrowser.Nodes.Count > 0) Then
            Return tlBrowser.Nodes(0)
        Else
            Return Nothing
        End If
    End Function
End Class
