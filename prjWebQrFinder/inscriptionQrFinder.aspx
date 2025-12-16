<%@ Page Title="Inscription" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="inscriptionQrFinder.aspx.cs" Inherits="prjWebQrFinder.inscriptionQrFinder" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

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
    </style>

    <div class="page-login d-flex flex-column align-items-center justify-content-center">

        <!-- Formulaire -->
        <div class="form-container">

            <!-- Illustration -->
            <div class="text-center mb-4">
                <h3>Creer votre compte</h3>
                <img src="/mesImages/objet.png" alt="Illustration" class="img-fluid" style="max-height: 120px;" />
            </div>

            <!-- Titre -->
            <p class="text-center mb-4">
                <i class="fas fa-user-circle me-2"></i>Vous avez déjà un compte ? 
          <a href="connexionQrFinder.aspx" class="accent">Connectez-vous</a>
            </p>
            <asp:ValidationSummary ID="ValidationSummary2" runat="server"  HeaderText="Veuillez corriger les erreurs suivantes :" CssClass="alert alert-danger rounded-3 mt-3 fw-semibold" />
            <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
           

            <!-- Role -->
            <div class="mb-4">
                <asp:Label ID="lblRole" runat="server" CssClass="form-label d-flex align-items-baseline">
                <i class="fas fa-user-tag me-2 text-primary"></i> Rôle
                </asp:Label>
                <asp:DropDownList ID="cboRole" OnSelectedIndexChanged="cboRole_SelectedIndexChanged" runat="server" CssClass="form-select form-select-lg">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="reqRole"
                    runat="server" ControlToValidate="cboRole"
                    Text="*"
                    InitialValue="0"
                    ForeColor="red"
                    ErrorMessage="Veuillez choisir un rôle" />
            </div>


            <!-- Civilite -->
            <div class="mb-4">
                <asp:Label ID="lblCivilite" runat="server" CssClass="form-label d-flex align-items-baseline">
        <i class="fas fa-user me-2 text-primary"></i> Civilité
                </asp:Label>
                <asp:DropDownList ID="cboCivilite" OnSelectedIndexChanged="cboCivilite_SelectedIndexChanged" runat="server" CssClass="form-select form-select-lg" />
                <asp:RequiredFieldValidator ID="reqCivilite" InitialValue="0" runat="server" ControlToValidate="cboCivilite"
                    Text="*" ForeColor="red" ErrorMessage="Veuillez choisir une civilité" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
            <div class="row mb-4">
                <!-- Nom -->
                <div class="col-md-6">
                    <asp:Label ID="lblNom" runat="server" CssClass="form-label d-flex align-items-baseline">
          <i class="fas fa-user me-2 text-primary"></i> Nom
                    </asp:Label>
                    <asp:TextBox ID="txtNom" runat="server" CssClass="form-control form-control-lg"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqNom" runat="server" ControlToValidate="txtNom"
                        Text="*" ForeColor="red" Display="Dynamic"
                        ErrorMessage="Nom requis">

                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revNom" runat="server"
                        ControlToValidate="txtNom"
                        Text="*"
                        Display="Dynamic"
                        ValidationExpression="^[a-zA-ZÀ-ÿ '-]+$"
                        ErrorMessage="Le nom doit etre en lettre uniquement.">

                    </asp:RegularExpressionValidator>
                </div>

                <!-- Prénom -->
                <div class="col-md-6">
                    <asp:Label ID="lblPrenom" runat="server" CssClass="form-label d-flex align-items-baseline">
          <i class="fas fa-user me-2 text-primary"></i> Prénom
                    </asp:Label>
                    <asp:TextBox ID="txtPrenom" runat="server" CssClass="form-control form-control-lg" />
                    <asp:RequiredFieldValidator ID="reqPrenom" runat="server" ControlToValidate="txtPrenom"
                        Text="*" ForeColor="red" ErrorMessage="Prénom requis" />
                    <asp:RegularExpressionValidator ID="revPrenom" runat="server"
                        ControlToValidate="txtPrenom"
                        Text="*"
                        Display="Dynamic"
                        ValidationExpression="^[a-zA-ZÀ-ÿ '-]+$"
                        ErrorMessage="Le prénom doit etre en lettre uniquement.">

                    </asp:RegularExpressionValidator>
                </div>
            </div>

            <!-- Email -->
            <div class="mb-4">
                <asp:Label ID="lblEmail" Font-Bold="true" runat="server" 
                    CssClass="form-label d-flex align-items-baseline">
                <i class="fas fa-envelope me-2 text-primary"></i> Email
                </asp:Label>
                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" Font-Bold="true" CssClass="form-control form-control-lg"></asp:TextBox>
                <asp:RequiredFieldValidator
                    ID="reqEmail"
                    runat="server"
                    Text="*"
                    ForeColor="red"
                    ControlToValidate="txtEmail"
                    Display="Dynamic"
                    ErrorMessage="Email requis">
                </asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator
                    ID="revEmail"
                    runat="server"
                    Text="*"
                    ForeColor="red"
                    ControlToValidate="txtEmail"
                    ErrorMessage="Email invalide"
                    Display="Dynamic"
                    ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$">
                </asp:RegularExpressionValidator>

            </div>
            <!-- Téléphone -->
            <div class="mb-4">
                <asp:Label ID="lblTel" runat="server" CssClass="form-label d-flex align-items-baseline">
            <i class="fas fa-phone me-2 text-primary"></i> Téléphone
                </asp:Label>
                <div class="row">
                    <asp:TextBox ID="txtTel" class="form-control form-control-lg" TextMode="Phone" runat="server" MaxLength="10" />
                </div>
                <asp:RequiredFieldValidator ID="reqTel"
                    runat="server" ControlToValidate="txtTel"
                    Text="*" ForeColor="red" ErrorMessage="Téléphone requis" 
                    Display="Dynamic">
                </asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator
                    ID="revTel"
                    runat="server"
                    ErrorMessage="Veuillez entrer un numéro de téléphone valide"
                    ForeColor="Red"
                    Display="Dynamic"
                    SetFocusOnError="true"
                    ControlToValidate="txtTel"
                    Text="*"
                    ValidationExpression="^(\+?\d{1,3}[- .]?)?(\d{10})$">
                </asp:RegularExpressionValidator>
            </div>

            <!-- Mot de passe -->
            <div class="mb-4 position-relative">
                <asp:Label ID="lblMotdepasse" runat="server" CssClass="form-label d-flex align-items-baseline">
                <i class="fas fa-lock me-2 text-primary"></i> Mot de passe
                </asp:Label>
                <asp:TextBox ID="txtMotdepasse" runat="server" CssClass="form-control form-control-lg" TextMode="Password" />
                <span class="position-absolute top-50 end-0 translate-middle-y me-3" onclick="togglePassword()" style="cursor: pointer;">
                    <i class="fas fa-eye" id="eyeIcon"></i>
                </span>
                <asp:RequiredFieldValidator ID="reqMotdepasse" runat="server" ControlToValidate="txtMotdepasse"
                    Text="*" ForeColor="red" ErrorMessage="Mot de passe requis"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator
                    ID="revMotdepasse"
                    runat="server"
                    Text="*"
                    ForeColor="red"
                    ErrorMessage="Le mot de passe doit contenir au moins 8 caractères, une majuscule, une minuscule, un chiffre et un caractère spécial."
                    ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"
                    ControlToValidate="txtMotdepasse">
                </asp:RegularExpressionValidator>
            </div>
            <!-- Consentement -->
            <div class="form-check mb-3">
                <asp:CheckBox ID="chkPartenaires" OnCheckedChanged="chkPartenaires_CheckedChanged" runat="server" />
                <asp:Label ID="Label2" runat="server" class="form-check-label"
                    Text="J'accepte de recevoir des infos et offres commerciales des partenaires de QRFinder (email, sms)"></asp:Label>
            </div>

            <div class="form-check mb-4">
                <asp:CheckBox ID="chkConditions" OnCheckedChanged="chkConditions_CheckedChanged" runat="server" />
                <asp:Label ID="Label1" class="form-check-label " runat="server" Text="J'ai lu et j'accepte les conditions d'utilisation ainsi que la politique de confidentialité"></asp:Label>
            </div>
            <!-- Bouton -->

            <div class="d-grid">
                <asp:Button ID="btnInscrire" runat="server" Text="Accepter >" 
                    OnClick="btnInscrire_Click" 
                    CssClass="btn btn-success btn-sm rounded-pill text-white fw-bold" />
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
