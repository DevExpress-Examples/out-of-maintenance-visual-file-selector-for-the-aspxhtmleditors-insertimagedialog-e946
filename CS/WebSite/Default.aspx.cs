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
using DevExpress.Web.ASPxTreeList;
using System.Collections.Generic;
using System.IO;

public partial class _Default : System.Web.UI.Page {
    public const string ImagesFolder = "UploadImages";
    public const string FolderImageUrl = "Images/Folder.png";

    protected void Page_Load(object sender, EventArgs e) {
        
    }
    protected void treeList_VirtualModeCreateChildren(object sender, TreeListVirtualModeCreateChildrenEventArgs e) {
        string path = e.NodeObject == null ? Page.MapPath("~/" + ImagesFolder + "/") : e.NodeObject.ToString();

        List<string> children = new List<string>();
        if(Directory.Exists(path)) {
            foreach(string name in Directory.GetDirectories(path)) {
                children.Add(name);
            }
            foreach(string name in Directory.GetFiles(path))
                if(IsImageFile(name))
                    children.Add(name);
        }
        e.Children = children;
    }

    protected void treeList_VirtualModeNodeCreating(object sender, TreeListVirtualModeNodeCreatingEventArgs e) {
        string nodePath = e.NodeObject.ToString();
        e.NodeKeyValue = GetNodeGuid(nodePath);
        e.IsLeaf = !Directory.Exists(nodePath);
        e.SetNodeValue("name", Path.GetFileName(nodePath));
        e.SetNodeValue("date", Directory.GetCreationTime(nodePath));
        e.SetNodeValue("url", Directory.Exists(nodePath) ? FolderImageUrl : GetNodeUrl(nodePath));
    }


    Guid GetNodeGuid(string path) {
        if(!Map.ContainsKey(path)) 
            Map[path] = Guid.NewGuid(); 
        return Map[path];
    }
    Dictionary<string, Guid> Map {
        get { const string key = "DX_PATH_GUID_MAP"; 
            if(Session[key] == null) Session[key] = new Dictionary<string, Guid>(); 
                return Session[key] as Dictionary<string, Guid>; 
        }
    }
    bool IsImageFile(string name) {
        string extension = Path.GetExtension(name).ToLower();
        return extension == ".png" || extension == ".gif" || extension == ".jpg" || extension == ".jpeg";
    }
    protected void tlBrowser_CustomDataCallback(object sender, TreeListCustomDataCallbackEventArgs e) {
        string[] parameters = e.Argument.Split(new string[] { "~" }, StringSplitOptions.None);
        if(parameters.Length == 2) {
            TreeListNode node = tlBrowser.FindNodeByKeyValue(parameters[1]);
            if(node != null)
                e.Result = parameters[0] + "~" + node.GetValue("url");
        }
    }
    protected void tlBrowser_CustomJSProperties(object sender, TreeListCustomJSPropertiesEventArgs e) {
        TreeListNode node = GetFirstNode();
        if(node != null) {
            e.Properties["cpFirstNodeKey"] = node.Key;
            e.Properties["cpFirstNodeUrl"] = node.GetValue("url");
        }
        e.Properties["cpFolderUrl"] = FolderImageUrl;
    }
    private string GetNodeUrl(string path) {
        string url = path;
        int pos = url.IndexOf(ImagesFolder);
        if(pos > -1) {
            url = url.Substring(pos);
            url = url.Replace("\\", "/");
        }
        return url;
    }
    private TreeListNode GetFirstNode() {
        return (tlBrowser.Nodes.Count > 0) ? tlBrowser.Nodes[0] : null;
    }
}
