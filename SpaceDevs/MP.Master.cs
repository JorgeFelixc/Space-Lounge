using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MongoDB.Driver;
using SpaceDevs.Models;
using MongoDB.Bson;

namespace SpaceDevs
{
    public partial class MP : System.Web.UI.MasterPage
    {
        const string connectionString = "mongodb://localhost:27017";
        MongoClient client = new MongoClient(connectionString);
        

        protected void Page_Load(object sender, EventArgs e)
        {
            //a que buen peish LOAD :D
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            var database = client.GetDatabase("spaceDev");
            var collection = database.GetCollection<users>("usuarios");

            if(txtRegPass.Text == "") {
                lblRegError.Text = "Campo invalido";
                return;
            }

            if(txtRegUser.Text == "")
            {
                lblRegError.Text = "Campo invalido";
                return;
            }
            users us = new users();
            us.password = txtRegPass.Text;
            us.usuario = txtRegUser.Text;

            var builder = Builders<users>.Filter;
            var filt = builder.Eq("password", txtLogPass.Text) & builder.Eq("usuario", txtLogUser.Text);
            var list = collection.Find(filt).ToListAsync().GetAwaiter().GetResult();
            if(list == null || list.Count != 0)
            {
                txtRegPass.Text = "";
                lblRegError.Text = "Campos ya registrados";
                return;
            }

            lblRegError.Text = "";
            collection.InsertOne(us);
        }

        protected  void Button2_Click(object sender, EventArgs e)
        {
            var database = client.GetDatabase("spaceDev");
            var collection = database.GetCollection<users>("usuarios");
            if (txtLogPass.Text == "")
            {
                lblError.Text = "Rellena los campos correctamente";
                return;
            }

            if (txtLogUser.Text == "")
            {
                lblError.Text = "Rellena los campos correctamente";
                return;
            }
            users us = new Models.users();
            us.password = txtLogPass.Text;
            us.usuario = txtLogUser.Text;
            var builder = Builders<users>.Filter;
            var filt = builder.Eq("password", txtLogPass.Text) & builder.Eq("usuario", txtLogUser.Text);
            var list = collection.Find(filt).ToListAsync().GetAwaiter().GetResult();
            if(list.Count == 0)
            {
                txtLogPass.Text = "";
                lblError.Text = "No existe el usuario o es falso";
                return;
            }

            lblUser.Text = "Bienvenido: " + us.usuario;
            lblError.Text = "";

        }
    }
}