<%@ Page Title="Connexion" Language="C#" MasterPageFile="~/MasterPageConnexion.master" AutoEventWireup="true" CodeBehind="connexionQrFinder.aspx.cs" Inherits="prjWebQrFinder.connexionFinder" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8" />
    <title>Connexion - QR Finder</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <style type="text/css">
        .page-login {
            min-height: 100vh;
            background-color: var(--gray);
            padding: 40px 20px;
        }

        .form-container {
            width: 100%;
            max-width: 600px;
            height: auto;
            background-color: var(--white);
            padding: 30px;
            border-radius: 15px;
            box-shadow: var(--shadow-hover);
        }

        .form-container h2 {
            font-size: 1.7rem;
            font-weight: bold;
            color: var(--dark);
        }

        .form-label {
            font-weight: 600;
            color: var(--text-light);
            font-size: 1rem;
            display: block;
            margin-bottom: 8px;
        }

        .form-control-lg {
            font-size: 1rem;
            padding: 14px 16px;
            border-radius: 10px;
            border: 1px solid var(--gray-dark);
            background-color: var(--white);
            color: var(--text);
        }

        .form-control-lg:focus {
            border-color: var(--primary);
            box-shadow: 0 0 6px rgba(149, 200, 222, 0.5);
            outline: none;
        }

        .btn-login {
            background-color: var(--primary);
            color: var(--white);
            padding: 16px 30px;
            border: none;
            border-radius: 10px;
            font-size: 1.2em;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .btn-login:hover {
            background-color: var(--accent);
            transform: scale(1.03);
        }

        .links-utiles a,
        .links-utiles .lien-utile {
            font-size: 0.9rem;
            margin-right: 1rem;
            color: var(--primary);
            text-decoration: none;
        }

        .links-utiles .accent {
            color: var(--accent);
        }

        .reseaux-sociaux {
            margin-top: 30px;
            font-size: 1rem;
            color: var(--text-light);
        }

        .social-icon {
            font-size: 1.5rem;
            color: var(--primary);
            transition: transform 0.3s ease, color 0.3s ease;
            text-decoration: none;
        }

        .social-icon:hover {
            transform: scale(1.2);
            color: var(--accent);
        }
        .input-group .form-control-lg {
  padding-right: 50px; /* espace pour l’icône à droite */
}

.input-group-text i {
  font-size: 1.1rem;
  color: var(--text-light);
}
    </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <div class="page-login d-flex flex-column align-items-center justify-content-center">

    <!-- Formulaire -->
    <div class="form-container">

      <!-- Illustration -->
      <div class="text-center mb-4">
        <img src="/images/profile-img.png" alt="Illustration" class="img-fluid" style="max-height: 120px;" />
      </div>

      <!-- Titre -->
      <h2 class="text-center mb-4">
        <i class="fas fa-user-circle me-2"></i>Connexion à votre compte
      </h2>
      <div class="alert alert-danger d-flex align-items-center mt-3" role="alert">
            <i class="fas fa-exclamation-triangle me-2 fa-lg text-danger"></i>
            <asp:ValidationSummary 
              ID="ValidationSummary1" 
              runat="server" 
              CssClass="mb-0" 
              HeaderText="Veuillez corriger les erreurs suivantes :" 
              DisplayMode="BulletList" 
               />
    </div>

      <!-- Email -->
      <div class="mb-4">
        <asp:Label ID="lblEmail" Font-Bold="true" runat="server" CssClass="form-label d-flex align-items-baseline">
            <i class="fas fa-envelope me-2 text-primary"></i> Email
        </asp:Label>
        <asp:TextBox ID="txtEmail" runat="server"  Font-Bold="true" CssClass="form-control form-control-lg" ></asp:TextBox>
          <asp:RequiredFieldValidator
              ID="reqEmail"
              runat="server"
              Text="*"
              ForeColor="red"
              ControlToValidate="txtEmail"
              ErrorMessage="Email requis">
          </asp:RequiredFieldValidator>
          <asp:RegularExpressionValidator
              ID="revEmail"
              runat="server"
              Text="*"
              ForeColor="red"
              ControlToValidate="txtEmail"
              ErrorMessage="Email invalide"
              ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$">
          </asp:RegularExpressionValidator>
      </div>

      <!-- Mot de passe -->
<div class="mb-4 position-relative">
  <asp:Label ID="lbltdepasse" Font-Bold="true" runat="server" CssClass="form-label d-flex align-items-baseline">
    <i class="fas fa-lock me-2 text-primary"></i>Mot de passe
  </asp:Label>

  <div class="input-group">
    <asp:TextBox ID="txtMotdepasse" runat="server" TextMode="Password" Font-Bold="true"
      CssClass="form-control form-control-lg pe-5" />
    <span class="input-group-text bg-white border-0 position-absolute end-0 top-50 translate-middle-y me-2"
      onclick="togglePassword()" style="cursor:pointer; z-index: 10;">
      <i class="fas fa-eye" id="eyeIcon"></i>
    </span>
  </div>

  <asp:RequiredFieldValidator
    ID="reqMotdepasse"
    runat="server"
    Text="*"
    ForeColor="red"
    ControlToValidate="txtMotdepasse"
    ErrorMessage="Mot de passe requis">
  </asp:RequiredFieldValidator>
</div>

      <!-- Message d'erreur -->
      <asp:Label ID="lblMsgErreur" runat="server" CssClass="text-danger d-block mb-3" />

      <!-- Bouton -->
      <div class="d-grid gap-2">
        <asp:Button ID="btnConnecter"
            runat="server" 
            Text="Se connecter"
             OnClick="btnConnecter_Click"
            CssClass="btn btn-lg btn-login" />
      </div>

      <!-- Liens utiles -->
      <div class="mt-4 text-center links-utiles">
        <a href="#" class="lien-utile">Mot de passe oublié ?</a>        
      </div>

    </div>

    <!-- Réseaux sociaux -->
   <p class="mb-2">On reste en contact ? Suivez-nous !</p>
    <div class="reseaux-sociaux text-center">
      
      <div class="d-flex justify-content-center gap-3">
        <a href="#" class="social-icon"><i class="fab fa-facebook-f"></i></a>
        <a href="#" class="social-icon"><i class="fab fa-instagram"></i></a>
        <a href="#" class="social-icon"><i class="fab fa-linkedin-in"></i></a>
      </div>
    </div>

  </div>
<script>
        function togglePassword() {
          var input = document.getElementById('<%= txtMotdepasse.ClientID %>');
          var icon = document.getElementById('eyeIcon');
          if (input.type === "password") {
            input.type = "text";
            icon.classList.replace("fa-eye", "fa-eye-slash");
          } else {
            input.type = "password";
            icon.classList.replace("fa-eye-slash", "fa-eye");
          }
        }
</script>
</asp:Content>





