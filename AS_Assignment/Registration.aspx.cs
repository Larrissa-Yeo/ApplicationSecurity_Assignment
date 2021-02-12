using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace AS_Assignment
{
    public partial class Registration : System.Web.UI.Page
    {
        string MyASDBConnectionString = System.Configuration.ConfigurationManager.
            ConnectionStrings["MyASDBConnection"].ConnectionString;
        static string finalHash;
        static string salt;
        byte[] Key;
        byte[] IV;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private int checkPassword(string password)
        {
            int score = 0;

            if (password.Length < 8)
            {
                return 1;
            }
            else
            {
                score = 1;
            }

            if (Regex.IsMatch(password, "[a-z]"))
            {
                score++;
            }

            if (Regex.IsMatch(password, "[A-Z]"))
            {
                score++;
            }

            if (Regex.IsMatch(password, "[0-9]"))
            {
                score++;
            }

            if (Regex.IsMatch(password, "[^A-Za-z0-9]"))
            {
                score++;
            }

            return score;

        }

        protected byte[] encryptData(string data)
        {
            byte[] cipherText = null;
            try
            {
                RijndaelManaged cipher = new RijndaelManaged();
                cipher.IV = IV;
                cipher.Key = Key;
                ICryptoTransform encryptTransform = cipher.CreateEncryptor();
                byte[] plainText = Encoding.UTF8.GetBytes(data);
                cipherText = encryptTransform.TransformFinalBlock(plainText, 0, plainText.Length);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { }
            return cipherText;
        }

        public void createAccount()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(MyASDBConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("INSERT INTO Account VALUES(@Email, @FName, " +
                        "@LName, @CreditCard, @PasswordHash, @PasswordSalt, @Dob, @IV, @Key)"))
                    {
                        using (SqlDataAdapter sda = new SqlDataAdapter())
                        {
                            cmd.CommandType = CommandType.Text;
                            cmd.Parameters.AddWithValue("@Email", Convert.ToBase64String(encryptData(tb_email.Text.Trim())));
                            cmd.Parameters.AddWithValue("@FName", tb_fName.Text.Trim());
                            cmd.Parameters.AddWithValue("@LName", tb_lName.Text.Trim());
                            cmd.Parameters.AddWithValue("@CreditCard", encryptData(tb_credit.Text.Trim()));
                            cmd.Parameters.AddWithValue("@PasswordHash", finalHash);
                            cmd.Parameters.AddWithValue("@PasswordSalt", salt);
                            cmd.Parameters.AddWithValue("@Dob", tb_dob.Text.Trim());
                            cmd.Parameters.AddWithValue("@IV", Convert.ToBase64String(IV));
                            cmd.Parameters.AddWithValue("@Key", Convert.ToBase64String(Key));
                            cmd.Connection = con;
                            con.Open();
                            cmd.ExecuteNonQuery();
                            con.Close();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
        }

        protected void btn_checkPassword_Click(object sender, EventArgs e)
        {
            int scores = checkPassword(tb_password.Text);
            string status = "";
            switch (scores)
            {
                case 1:
                    status = "Very Weak";
                    break;
                case 2:
                    status = "Weak";
                    break;
                case 3:
                    status = "Medium";
                    break;
                case 4:
                    status = "Strong";
                    break;
                case 5:
                    status = "Excellent";
                    break;
                default:
                    break;
            }

            lbl_pwdchecker.Text = "Status : " + status;
            if (scores < 4)
            {
                lbl_pwdchecker.ForeColor = Color.Red;
                return;
            }
            lbl_pwdchecker.ForeColor = Color.Green;

            string pwd = tb_password.Text.ToString().Trim();
            RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
            byte[] saltByte = new byte[8];

            rng.GetBytes(saltByte);
            salt = Convert.ToBase64String(saltByte);

            SHA512Managed hashing = new SHA512Managed();

            string pwdWithSalt = pwd + salt;
            byte[] plainHash = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwd));
            byte[] hashWithSalt = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwdWithSalt));

            finalHash = Convert.ToBase64String(hashWithSalt);

            RijndaelManaged cipher = new RijndaelManaged();
            cipher.GenerateKey();
            Key = cipher.Key;
            IV = cipher.IV;

            createAccount();

            // Captcha
            if (tb_verification.Text.ToLower() == Session["CaptchaVerify"].ToString())
            {
                // Session Fixation
                Response.Redirect("login.aspx?Comment=" + HttpUtility.UrlEncode(HttpUtility.HtmlEncode(tb_fName.Text))
                    + HttpUtility.UrlEncode(HttpUtility.HtmlEncode(tb_lName.Text)) + HttpUtility.UrlEncode(HttpUtility.HtmlEncode(tb_credit.Text)) +
                    HttpUtility.UrlEncode(HttpUtility.HtmlEncode(tb_email.Text)) + HttpUtility.UrlEncode(HttpUtility.HtmlEncode(tb_password.Text)) +
                    HttpUtility.UrlEncode(HttpUtility.HtmlEncode(tb_dob.Text)));
            }
            else
            {
                lbl_captchaMessage.Text = "You have entered Wrong Captcha. Please enter correct Captcha !";
                lbl_captchaMessage.ForeColor = System.Drawing.Color.Red;
            }

            
        }

       
    }
}