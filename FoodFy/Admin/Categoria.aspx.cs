using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FoodFy.Admin
{
    public partial class Categoria : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                Session["breadCrum"] = "Categoria";
                GetCategoria();
            }
            lblMsg.Visible = false;
        }
        protected void btnAddOrUpdate_Click(object sender, EventArgs e)
        {
            string actionName = string.Empty, imagePath = string.Empty, fileExtension = string.Empty;
            bool isValidToExecute = false;
            int categoriaId = Convert.ToInt32(hdnId.Value);
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Categoria_Crud", con);
            cmd.Parameters.AddWithValue("@Action", categoriaId == 0 ? "INSERT" : "UPDATE");
            cmd.Parameters.AddWithValue("@CategoriaId", categoriaId);
            cmd.Parameters.AddWithValue("@Nome", txtNome.Text.Trim());
            cmd.Parameters.AddWithValue("@IsActive", cbIsActive.Checked);
            if (fuCategoriaImage.HasFile)
            {
                if (Utils.IsValidExtension(fuCategoriaImage.FileName))
                {
                    Guid obj = Guid.NewGuid();
                    fileExtension = Path.GetExtension(fuCategoriaImage.FileName);
                    imagePath = "Images/Categoria/" + obj.ToString() + fileExtension;
                    fuCategoriaImage.PostedFile.SaveAs(Server.MapPath("~/Images/Categoria/") + obj.ToString() + fileExtension);
                    cmd.Parameters.AddWithValue("@ImageUrl", imagePath);
                    isValidToExecute = true;
                }
                else
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Por favor selecione .jpg, .jpeg, ou png imagem";
                    lblMsg.CssClass = "alert alert-danger";
                }
            }
            else
            {
                isValidToExecute = true;
            }
          if (isValidToExecute)
            {
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    actionName = categoriaId == 0 ? "inserida" : "atualizada";
                    lblMsg.Visible = true;
                    lblMsg.Text = "Categoria " + actionName + " com sucesso!";
                    lblMsg.CssClass = "alert alert-sucess";
                    GetCategoria();
                    clear();
                }
                catch (Exception ex)
                {
                    lblMsg.Visible=true;
                    lblMsg.Text = "Error - " + ex.Message;
                    lblMsg.CssClass = "alert alert-danger";
                }
                finally
                {
                    con.Close();
                }
            }
        }

        private void GetCategoria()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Categoria_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "SELECT");
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rCategoria.DataSource = dt;
            rCategoria.DataBind();
        }

        private void clear()
        {
            txtNome.Text = string.Empty;
            cbIsActive.Checked = false;
            hdnId.Value = "0";
            btnAddOrUpdate.Text = "Add";
            imgCategoria.ImageUrl = String.Empty;   
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            clear();
        }
        protected void rCategoria_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            lblMsg.Visible = false;
            con = new SqlConnection(Connection.GetConnectionString());
            if (e.CommandName == "edit")
            {
                cmd = new SqlCommand("Categoria_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "GETBYID");
                cmd.Parameters.AddWithValue("@CategoriaId", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                txtNome.Text = dt.Rows[0]["Nome"].ToString();
                cbIsActive.Checked = Convert.ToBoolean(dt.Rows[0]["IsActive"]);
                imgCategoria.ImageUrl = String.IsNullOrEmpty(dt.Rows[0]["ImageUrl"].ToString()) ? 
                    "../Images/No_image.png" : "../" + dt.Rows[0]["ImageUrl"].ToString();
                imgCategoria.Height = 200;
                imgCategoria.Width = 200;
                hdnId.Value = dt.Rows[0]["CategoriaId"].ToString();
                btnAddOrUpdate.Text = "Update";
                LinkButton btn = e.Item.FindControl("lnkEdit") as LinkButton;
                btn.CssClass = "badge badge-warning";
            }
            else if (e.CommandName == "delete")
            {
                //con = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand("Categoria_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "DELETE");
                cmd.Parameters.AddWithValue("CategoriaId", e.CommandArgument);
                cmd.CommandType= CommandType.StoredProcedure;
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblMsg.Visible = true;
                    lblMsg.Text = "Categoria deletada com sucesso";
                    lblMsg.CssClass = "alert alert-sucess";
                    GetCategoria();
                }
                catch (Exception ex)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Error - " + ex.Message;
                    lblMsg.CssClass = "alert alert-danger";
                }
                finally
                {
                    con.Close();
                }
          
            }
        }
        protected void rCategoria_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lbl = e.Item.FindControl("lblIsActive") as Label;
                if (lbl.Text == "True")
                {
                    lbl.Text = "Active";
                    lbl.CssClass = " badge badge-success";
                }
                else
                {
                    lbl.Text = "In-Active";
                    lbl.CssClass = "badge badge-danger";
                }
            }
        }

    }

}