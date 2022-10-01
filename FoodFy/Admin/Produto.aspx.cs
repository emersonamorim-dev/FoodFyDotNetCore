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
    public partial class Produto : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["breadCrum"] = "Produto";
                GetProduto();
            }
            lblMsg.Visible = false;
        }
        protected void btnAddOrUpdate_Click(object sender, EventArgs e)
        {
            string actionName = string.Empty, imagePath = string.Empty, fileExtension = string.Empty;
            bool isValidToExecute = false;
            int produtoId = Convert.ToInt32(hdnId.Value);
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Produto_Crud", con);
            cmd.Parameters.AddWithValue("@Action", produtoId == 0 ? "INSERT" : "UPDATE");
            cmd.Parameters.AddWithValue("@ProdutoId", produtoId);
            cmd.Parameters.AddWithValue("@Nome", txtNome.Text.Trim());
            cmd.Parameters.AddWithValue("@Descricao", txtDescricao.Text.Trim());
            cmd.Parameters.AddWithValue("@Preco", txtPreco.Text.Trim());
            cmd.Parameters.AddWithValue("@Quantidade", txtQuantidade.Text.Trim());
            cmd.Parameters.AddWithValue("@CategoriaId", ddlCategoria.SelectedValue);
            cmd.Parameters.AddWithValue("@IsActive", cbIsActive.Checked);
            if (fuProdutoImage.HasFile)
            {
                if (Utils.IsValidExtension(fuProdutoImage.FileName))
                {
                    Guid obj = Guid.NewGuid();
                    fileExtension = Path.GetExtension(fuProdutoImage.FileName);
                    imagePath = "Images/Produto/" + obj.ToString() + fileExtension;
                    fuProdutoImage.PostedFile.SaveAs(Server.MapPath("~/Images/Produto/") + obj.ToString() + fileExtension);
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
                    actionName = produtoId == 0 ? "inserido" : "atualizado";
                    lblMsg.Visible = true;
                    lblMsg.Text = "Produto " + actionName + " com sucesso!";
                    lblMsg.CssClass = "alert alert-sucess";
                    GetProduto();
                    clear();
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

        private void GetProduto()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Produto_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "SELECT");
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rProduto.DataSource = dt;
            rProduto.DataBind();
        }

        private void clear()
        {
            txtNome.Text = string.Empty;
            txtDescricao.Text = string.Empty;
            txtQuantidade.Text = string.Empty;
            txtPreco.Text = string.Empty;
            ddlCategoria.ClearSelection();
            cbIsActive.Checked = false;
            hdnId.Value = "0";
            btnAddOrUpdate.Text = "Add";
            imgProduto.ImageUrl = String.Empty;
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            clear();
        }
        protected void rProduto_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            lblMsg.Visible = false;
            con = new SqlConnection(Connection.GetConnectionString());
            if (e.CommandName == "edit")
            {
                cmd = new SqlCommand("Produto_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "GETBYID");
                cmd.Parameters.AddWithValue("@ProdutoId", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                txtNome.Text = dt.Rows[0]["Nome"].ToString();
                txtDescricao.Text = dt.Rows[0]["Descricao"].ToString();
                txtPreco.Text = dt.Rows[0]["Preco"].ToString();
                txtQuantidade.Text = dt.Rows[0]["Quantidade"].ToString();
                ddlCategoria.SelectedValue = dt.Rows[0]["CategoriaId"].ToString();
                cbIsActive.Checked = Convert.ToBoolean(dt.Rows[0]["IsActive"]);
                imgProduto.ImageUrl = String.IsNullOrEmpty(dt.Rows[0]["ImageUrl"].ToString()) ?
                    "../Images/No_image.png" : "../" + dt.Rows[0]["ImageUrl"].ToString();
                imgProduto.Height = 200;
                imgProduto.Width = 200;
                hdnId.Value = dt.Rows[0]["ProdutoId"].ToString();
                btnAddOrUpdate.Text = "Update";
                LinkButton btn = e.Item.FindControl("lnkEdit") as LinkButton;
                btn.CssClass = "badge badge-warning";
            }
            else if (e.CommandName == "delete")
            {
                cmd = new SqlCommand("Produto_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "DELETE");
                cmd.Parameters.AddWithValue("ProdutoId", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblMsg.Visible = true;
                    lblMsg.Text = "Produto deletado com sucesso";
                    lblMsg.CssClass = "alert alert-sucess";
                    GetProduto();
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
        protected void rProduto_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lblIsActive = e.Item.FindControl("lblIsActive") as Label;
                Label lblQuantidade = e.Item.FindControl("lblQuantidade") as Label;
                if (lblIsActive.Text == "True")
                {
                    lblIsActive.Text = "Active";
                    lblIsActive.CssClass = " badge badge-success";
                }
                else
                {
                    lblIsActive.Text = "In-Active";
                    lblIsActive.CssClass = "badge badge-danger";
                }
                if (Convert.ToInt32(lblQuantidade.Text) <= 5)
                {
                    lblQuantidade.CssClass = "badge badge-danger";
                    lblQuantidade.ToolTip = "Item está fora de Estoque'!";
                }
            }
        }

    }

}