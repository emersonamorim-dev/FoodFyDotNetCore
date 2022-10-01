using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FoodFy.User
{
    public partial class Registration : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null) //&& Session["userId"] != null)
                {
                    getUserDetails();
                }
                else if (Session["userId"] != null)
                {
                    Response.Redirect("Default.aspx");
                }
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string actionName = string.Empty, imagePath = string.Empty, fileExtension = string.Empty;
            bool isValidToExecute = false;
            int userId = Convert.ToInt32(Request.QueryString["id"]);
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("User_Crud", con);
            cmd.Parameters.AddWithValue("@Action", userId == 0 ? "INSERT" : "UPDATE");
            cmd.Parameters.AddWithValue("@UserId", userId);
            cmd.Parameters.AddWithValue("@Nome", txtNome.Text.Trim());
            cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
            cmd.Parameters.AddWithValue("@Celular", txtCelular.Text.Trim());
            cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
            cmd.Parameters.AddWithValue("@Endereco", txtEndereco.Text.Trim());
            cmd.Parameters.AddWithValue("@CEP", txtCEP.Text.Trim());
            cmd.Parameters.AddWithValue("@Senha", txtSenha.Text.Trim());
            if (fuUserImage.HasFile)
            {
                if (Utils.IsValidExtension(fuUserImage.FileName))
                {
                    Guid obj = Guid.NewGuid();
                    fileExtension = Path.GetExtension(fuUserImage.FileName);
                    imagePath = "Images/Usuario/" + obj.ToString() + fileExtension;
                    fuUserImage.PostedFile.SaveAs(Server.MapPath("~/Images/Usuario/") + obj.ToString() + fileExtension);
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
                    actionName = userId == 0 ?
                        "registrado com sucesso! <b><a href='Entrar.aspx'> Clique Aqui</a></b> para entrar!" :
                        "detalhes atualizado com sucesso! <b><a href='Perfil.aspx'> Clique Aqui</a></b>";
                    lblMsg.Visible = true;
                    lblMsg.Text = "<b>" + txtUsername.Text.Trim() + "</b>" + actionName;
                    lblMsg.CssClass = "alert alert-sucess";
                    if (userId != 0)
                    {
                        Response.AddHeader("REFRESH", "1;URL=Perfil.aspx");
                    }
                    clear();
                }
                catch (SqlException ex)
                {
                    if (ex.Message.Contains("Violation of UNIQUE KEY constraint"))
                    {
                        lblMsg.Visible = true;
                        lblMsg.Text = "<b>" + txtUsername.Text.Trim() + "</b> usuário já existe, escolha outro!";
                        lblMsg.CssClass = "alert alert-danger";
                    }
                }
                catch (Exception ex)
                {

                    lblMsg.Visible = true;
                    lblMsg.Text = "Error-" + ex.Message;
                    lblMsg.CssClass = "alert alert-danger";
                }
                finally
                {
                    con.Close();
                }
            }
        }

        void getUserDetails()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("User_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "SELECT4PERFIL");
            cmd.Parameters.AddWithValue("@UserId", Request.QueryString["id"]);
            cmd.CommandType= CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count == 1)
            {
                txtNome.Text = dt.Rows[0]["Nome"].ToString();
                txtUsername.Text = dt.Rows[0]["Username"].ToString();
                txtCelular.Text = dt.Rows[0]["Celular"].ToString();
                txtEmail.Text = dt.Rows[0]["Email"].ToString();
                txtEndereco.Text = dt.Rows[0]["Endereco"].ToString();
                txtCEP.Text = dt.Rows[0]["CEP"].ToString();
                ImgUser.ImageUrl = String.IsNullOrEmpty(dt.Rows[0]["ImageUrl"].ToString())
                    ? "../Images/No_image.png" : "../" + dt.Rows[0]["ImageUrl"].ToString();
                ImgUser.Height = 200;
                ImgUser.Width = 200;
                txtSenha.TextMode = TextBoxMode.SingleLine;
                txtSenha.ReadOnly = true;
                txtSenha.Text = dt.Rows[0]["Senha"].ToString();

            }
            lblHeaderMsg.Text = "<h2>Editar Perfil</h2>";
            btnRegister.Text = "Update";
            lblAlreadyUser.Text = "";
        }

        private void clear()
        {
            txtNome.Text = string.Empty;
            txtUsername.Text = string.Empty;
            txtCelular.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtEndereco.Text = string.Empty;
            txtCEP.Text = string.Empty;
            txtSenha.Text = string.Empty;
        }
    }
}
