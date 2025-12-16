<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="DeclarerObjets.aspx.cs" Inherits="prjWebQrFinder.DeclarerObjets" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .declaration-container {
            max-width: 1200px;
            margin: 50px auto;
            padding: 30px;
        }

        .section-title {
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 30px;
            color: #0B1F3A;
        }

        .form-section {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }

        .section-subtitle {
            font-size: 1.2rem;
            font-weight: 600;
            color: #0B1F3A;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #FF7F00;
        }

        /* Boutons État */
        .btn-etat {
            padding: 15px 40px;
            border: 2px solid #e0e0e0;
            background: white;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s ease;
            cursor: pointer;
        }

            .btn-etat.active {
                background: #FF7F00;
                color: white;
                border-color: #FF7F00;
            }

            .btn-etat:hover {
                border-color: #0B1F3A;
            }

        /* Boutons Quand */
        .btn-quand {
            padding: 15px 30px;
            border: 2px solid #e0e0e0;
            background: white;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s ease;
            cursor: pointer;
        }

            .btn-quand.active {
                background: #0B1F3A;
                color: white;
                border-color: #0B1F3A;
            }

            .btn-quand:hover {
                border-color: #FF7F00;
            }

        /* Cartes de catégories */
        .category-card {
            border: 2px solid #e0e0e0;
            border-radius: 15px;
            padding: 20px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            height: 100%;
            display: block;
            text-decoration: none;
            color: #333;
        }

            .category-card:hover {
                border-color: #FF7F00;
                transform: translateY(-5px);
                box-shadow: 0 5px 15px rgba(255, 127, 0, 0.2);
                text-decoration: none;
            }

            .category-card.selected {
                background: #4ECDC4;
                border-color: #4ECDC4;
                color: white;
            }

        .category-icon {
            font-size: 3rem;
            margin-bottom: 10px;
        }

        /* Sous-catégories */
        .subcategory-card {
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            padding: 15px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            display: block;
            text-decoration: none;
            color: #333;
            min-height: 100px;
        }

            .subcategory-card:hover {
                border-color: #FF7F00;
                transform: translateY(-3px);
                text-decoration: none;
            }

            .subcategory-card.selected {
                background: #4ECDC4;
                border-color: #4ECDC4;
                color: white;
            }

        .subcategory-icon {
            font-size: 2rem;
            margin-bottom: 10px;
        }

        /* Boutons couleur */
        .btn-couleur {
            padding: 15px 30px;
            border: 2px solid #e0e0e0;
            background: white;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

            .btn-couleur.selected {
                border: 3px solid #FF7F00;
                background: #fff3e0;
            }

            .btn-couleur:hover {
                border-color: #FF7F00;
            }

        .color-circle {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            display: inline-block;
            margin-right: 10px;
            vertical-align: middle;
        }

        /* Bouton publier */
        .btn-publier {
            background: #FF7F00;
            color: white;
            padding: 18px 60px;
            border: none;
            border-radius: 50px;
            font-size: 1.1rem;
            font-weight: bold;
            width: 100%;
            max-width: 500px;
            transition: all 0.3s ease;
        }

            .btn-publier:hover {
                background: #0B1F3A;
                transform: translateY(-2px);
                box-shadow: 0 5px 20px rgba(78, 205, 196, 0.4);
            }

        /* Tabs pour le lieu */
        .lieu-tabs {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            border-bottom: 2px solid #e0e0e0;
            flex-wrap: wrap;
        }

        .lieu-tab {
            padding: 10px 20px;
            border: none;
            background: transparent;
            border-bottom: 3px solid transparent;
            cursor: pointer;
            font-weight: 600;
            color: #666;
            transition: all 0.3s ease;
        }

            .lieu-tab.active {
                color: #0B1F3A;
                border-bottom-color: #FF7F00;
            }

            .lieu-tab:hover {
                color: #FF7F00;
            }

        /* Bouton retour */
        .btn-retour {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            color: #0B1F3A;
            font-weight: 600;
            text-decoration: none;
            padding: 10px 20px;
            border: 2px solid #0B1F3A;
            border-radius: 10px;
            transition: all 0.3s ease;
        }

            .btn-retour:hover {
                background: #0B1F3A;
                color: white;
                text-decoration: none;
            }

        /* Responsive */
        @media (max-width: 768px) {
            .declaration-container {
                padding: 15px;
            }

            .section-title {
                font-size: 1.5rem;
            }

            .form-section {
                padding: 20px;
            }

            .btn-etat, .btn-quand {
                padding: 12px 25px;
                font-size: 0.9rem;
            }

            .category-icon {
                font-size: 2rem;
            }
        }

        /* Boutons couleur avec pastilles */
        .btn-couleur {
            position: relative;
            padding-left: 45px;
        }

            .btn-couleur::before {
                content: '';
                position: absolute;
                left: 10px;
                top: 50%;
                transform: translateY(-50%);
                width: 25px;
                height: 25px;
                border-radius: 50%;
                border: 2px solid #ddd;
            }

        .btn-couleur-noir::before {
            background: black;
        }

        .btn-couleur-gris::before {
            background: gray;
        }

        .btn-couleur-blanc::before {
            background: white;
            border-color: #333;
        }

        .btn-couleur-creme::before {
            background: #FFFDD0;
        }

        .btn-couleur-rouge::before {
            background: red;
        }

        .btn-couleur-bleu::before {
            background: blue;
        }

        .btn-couleur-vert::before {
            background: green;
        }
    </style>

    <div class="declaration-container">
        <!-- Titre -->
        <h1 class="section-title">
            <i class="bi bi-plus-circle me-2" style="color: #FF7F00;"></i>
            Déclarer un objet
        </h1>

        <!-- Section 1: État -->
        <div class="form-section">
            <h3 class="section-subtitle">État</h3>
            <div class="d-flex gap-3 flex-wrap">
                <asp:Button ID="btnPerdu" runat="server" Text="Perdu" CssClass="btn-etat active" OnClick="btnEtat_Click" />
                <asp:Button ID="btnTrouve" runat="server" Text="Trouvé" CssClass="btn-etat" OnClick="btnEtat_Click" />
                <asp:HiddenField ID="hfEtat" runat="server" Value="Perdu" />
            </div>
        </div>

        <!-- Section 2: Où -->
        <div class="form-section">
            <h3 class="section-subtitle">Où</h3>
            <div class="lieu-tabs">
                <button type="button" class="lieu-tab active" data-tab="adresse">Adresse</button>
                <button type="button" class="lieu-tab" data-tab="transport">Transport</button>
                <button type="button" class="lieu-tab" data-tab="aeroport">Aéroport</button>
                <button type="button" class="lieu-tab" data-tab="mairie">Mairie / Police</button>
            </div>
            <asp:TextBox ID="txtLieu" runat="server" CssClass="form-control" placeholder="Saisissez l'adresse de la perte / trouvaille"></asp:TextBox>
        </div>

        <!-- Section 3: Quand -->
        <div class="form-section">
            <h3 class="section-subtitle">Quand ?</h3>
            <div class="d-flex gap-3 flex-wrap mb-3">
                <asp:Button ID="btnAujourdhui" runat="server" Text="Aujourd'hui" CssClass="btn-quand active" OnClick="btnQuand_Click" />
                <asp:Button ID="btnHier" runat="server" Text="Hier" CssClass="btn-quand" OnClick="btnQuand_Click" />
                <asp:Button ID="btnAvantHier" runat="server" Text="Avant-hier" CssClass="btn-quand" OnClick="btnQuand_Click" />
                <asp:HiddenField ID="hfQuand" runat="server" />
            </div>
            <div>
                <label class="form-label fw-bold">Ou choisissez une date et heure précise :</label>
                <asp:TextBox ID="txtDatePrecise" runat="server" TextMode="DateTimeLocal" CssClass="form-control"></asp:TextBox>
            </div>
        </div>

        <!-- Section 4: Catégories -->
        <div class="form-section">
            <h3 class="section-subtitle">Sélectionnez une catégorie *</h3>
            <div class="row g-3">
                <asp:Repeater ID="rptCategories" runat="server" OnItemCommand="rptCategories_ItemCommand">
                    <ItemTemplate>
                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <asp:LinkButton ID="btnCategorie" runat="server"
                                CommandName="SelectCategorie"
                                CommandArgument='<%# Eval("CategorieID") %>'
                                CssClass="category-card">
                                <div class="category-icon"><%# Eval("IconeCategorie") %></div>
                                <div class="fw-bold"><%# Eval("NomCategorie") %></div>
                            </asp:LinkButton>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <asp:HiddenField ID="hfCategorieSelectionnee" runat="server" />
        </div>

        <!-- Section 5: Sous-catégories (apparaît après sélection) -->
        <asp:Panel ID="pnlSousCategories" runat="server" Visible="false" CssClass="form-section">
            <div class="mb-3">
                <asp:LinkButton ID="btnRetourCategories" runat="server" OnClick="btnRetourCategories_Click" CssClass="btn-retour">
                    <i class="bi bi-chevron-left fs-5"></i>
                    <span>Retour aux catégories</span>
                </asp:LinkButton>
            </div>
            <h3 class="section-subtitle">Choisissez le type d'objet</h3>
            <div class="row g-3">
                <asp:Repeater ID="rptSousCategories" runat="server" OnItemCommand="rptSousCategories_ItemCommand">
                    <ItemTemplate>
                        <div class="col-lg-2 col-md-3 col-sm-4 col-6">
                            <asp:LinkButton ID="btnSousCategorie" runat="server"
                                CommandName="SelectSousCategorie"
                                CommandArgument='<%# Eval("SousCategorieID") %>'
                                CssClass="subcategory-card">
                                <div class="subcategory-icon"><%# Eval("IconeSousCategorie") %></div>
                                <div class="fw-bold"><%# Eval("NomSousCategorie") %></div>
                            </asp:LinkButton>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <asp:HiddenField ID="hfSousCategorieSelectionnee" runat="server" />
        </asp:Panel>

        <!-- Section 6: Détails de l'objet -->
        <asp:Panel ID="pnlDetailsObjet" runat="server" Visible="false" CssClass="form-section">
            <h3 class="section-subtitle">Décrivez votre objet</h3>

            <!-- Marque -->
            <div class="mb-3">
                <label class="form-label fw-bold">Marque *</label>
                <asp:TextBox ID="txtMarque" runat="server" CssClass="form-control" placeholder="Indiquez la marque"></asp:TextBox>
                <div class="form-check mt-2">
                    <asp:CheckBox ID="chkPasDeMarque" runat="server" CssClass="form-check-input" />
                    <label class="form-check-label">Pas de marque</label>
                </div>
            </div>

            <!-- Photo -->
            <div class="mb-3">
                <label class="form-label fw-bold">Photo de l'objet</label>
                <asp:FileUpload ID="filePhoto" runat="server" CssClass="form-control" accept="image/*" />
                <small class="text-muted">Photo de l'objet uniquement sans données personnelles, ou capture d'écran sur un site de vente en ligne</small>
            </div>

            <!-- Prénom (si c'est un document) -->
            <div class="mb-3">
                <label class="form-label fw-bold">Prénom <small class="text-muted">(si applicable)</small></label>
                <asp:TextBox ID="txtPrenom" runat="server" CssClass="form-control" placeholder="Indiquez le prénom"></asp:TextBox>
            </div>

            <!-- Nom (si c'est un document) -->
            <div class="mb-3">
                <label class="form-label fw-bold">Nom <small class="text-muted">(si applicable)</small></label>
                <asp:TextBox ID="txtNom" runat="server" CssClass="form-control" placeholder="Indiquez le nom"></asp:TextBox>
            </div>

            <!-- Couleur -->
            <div class="mb-3">
                <label class="form-label fw-bold">Couleur de l'objet</label>
                <div class="d-flex gap-2 flex-wrap mb-2">
                    <asp:Button ID="btnNoir" runat="server" Text="⚫ Noir" CssClass="btn-couleur" OnClick="btnCouleur_Click" />
                    <asp:Button ID="btnGris" runat="server" Text="🔘 Gris" CssClass="btn-couleur" OnClick="btnCouleur_Click" />
                    <asp:Button ID="btnBlanc" runat="server" Text="⚪ Blanc" CssClass="btn-couleur" OnClick="btnCouleur_Click" />
                    <asp:Button ID="btnCreme" runat="server" Text="🟡 Crème" CssClass="btn-couleur" OnClick="btnCouleur_Click" />
                    <asp:Button ID="btnRouge" runat="server" Text="🔴 Rouge" CssClass="btn-couleur" OnClick="btnCouleur_Click" />
                    <asp:Button ID="btnBleu" runat="server" Text="🔵 Bleu" CssClass="btn-couleur" OnClick="btnCouleur_Click" />
                    <asp:Button ID="btnVert" runat="server" Text="🟢 Vert" CssClass="btn-couleur" OnClick="btnCouleur_Click" />
                    <asp:Button ID="btnJaune" runat="server" Text="🟡 Jaune" CssClass="btn-couleur" OnClick="btnCouleur_Click" />
                    <asp:Button ID="btnOrange" runat="server" Text="🟠 Orange" CssClass="btn-couleur" OnClick="btnCouleur_Click" />
                    <asp:Button ID="btnRose" runat="server" Text="🌸 Rose" CssClass="btn-couleur" OnClick="btnCouleur_Click" />
                    <asp:Button ID="btnMarron" runat="server" Text="🟤 Marron" CssClass="btn-couleur" OnClick="btnCouleur_Click" />
                </div>
                <asp:TextBox ID="txtAutreCouleur" runat="server" CssClass="form-control" placeholder="Ou indiquez une autre couleur"></asp:TextBox>
                <asp:HiddenField ID="hfCouleur" runat="server" />
            </div>

            <!-- Matériel -->
            <div class="mb-3">
                <label class="form-label fw-bold">Matériel</label>
                <asp:TextBox ID="txtMateriel" runat="server" CssClass="form-control" placeholder="Indiquez le matériel (ex: or, argent, plastique)"></asp:TextBox>
            </div>

            <!-- Modèle -->
            <div class="mb-3">
                <label class="form-label fw-bold">Modèle</label>
                <asp:TextBox ID="txtModele" runat="server" CssClass="form-control" placeholder="Indiquez le modèle"></asp:TextBox>
            </div>

            <!-- État -->
            <div class="mb-3">
                <label class="form-label fw-bold">État</label>
                <asp:DropDownList ID="ddlEtatObjet" runat="server" CssClass="form-select">
                    <asp:ListItem Value="">Indiquez le niveau d'usure</asp:ListItem>
                    <asp:ListItem Value="Neuf">Neuf</asp:ListItem>
                    <asp:ListItem Value="Comme neuf">Comme neuf</asp:ListItem>
                    <asp:ListItem Value="Bon état">Bon état</asp:ListItem>
                    <asp:ListItem Value="Usé">Usé</asp:ListItem>
                    <asp:ListItem Value="Endommagé">Endommagé</asp:ListItem>
                </asp:DropDownList>
            </div>

            <!-- Détail -->
            <div class="mb-3">
                <label class="form-label fw-bold">Détail</label>
                <asp:TextBox ID="txtDetail" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control"
                    placeholder="Décrire au mieux l'objet et ses éléments distinctifs. Ne pas indiquer de nom, prénom, adresse ou numéro de référence."></asp:TextBox>
            </div>

            <!-- Question d'authentification -->
            <div class="mb-3">
                <div class="alert alert-info">
                    <i class="bi bi-info-circle me-2"></i>
                    <strong>Ajouter ma question d'authentification</strong>
                    <p class="mb-0 mt-2 small">
                        Cette question permet de prouver votre bonne foi, donnez une information que vous êtes le seul à connaître sur votre objet.
                   
                    </p>
                </div>
                <asp:TextBox ID="txtQuestionAuth" runat="server" CssClass="form-control"
                    placeholder="Ex: Quelle couleur de bracelet avait la montre ?"></asp:TextBox>
            </div>

            <!-- RGPD -->
            <div class="alert alert-warning">
                <h6><i class="bi bi-shield-check me-2"></i>En conformité avec la réglementation RGPD</h6>
                <p class="small mb-0">
                    Veuillez ne saisir aucune des données suivantes (même si elle figure sur l'objet perdu/trouvé) : 
                    numéro de sécurité sociale, données sur l'origine raciale, ethnique, l'opinion politique, 
                    l'appartenance syndicale, les convictions religieuses ou philosophiques, l'orientation sexuelle 
                    ou données de santé.
               
                </p>
            </div>
        </asp:Panel>

        <!-- Message de confirmation ou erreur -->
        <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="alert">
            <asp:Label ID="lblMessage" runat="server"></asp:Label>
        </asp:Panel>

        <!-- Bouton Publier -->
        <div class="text-center mt-5">
            <asp:Button ID="btnPublier" runat="server" Text="Publier l'annonce" CssClass="btn-publier" OnClick="btnPublier_Click" />
        </div>
    </div>

    <script>
        $(document).ready(function () {
            // Gestion des tabs de lieu
            $('.lieu-tab').click(function () {
                $('.lieu-tab').removeClass('active');
                $(this).addClass('active');

                var tab = $(this).data('tab');
                var placeholder = '';

                switch (tab) {
                    case 'adresse':
                        placeholder = 'Saisissez l\'adresse de la perte / trouvaille';
                        break;
                    case 'transport':
                        placeholder = 'Ex: Bus 24, Métro ligne 2, Train Montréal-Québec';
                        break;
                    case 'aeroport':
                        placeholder = 'Ex: Aéroport Pierre-Elliott-Trudeau, Terminal 1';
                        break;
                    case 'mairie':
                        placeholder = 'Ex: Mairie de Montréal, Poste de police du Plateau';
                        break;
                }

                $('#<%= txtLieu.ClientID %>').attr('placeholder', placeholder);
            });
        });
    </script>
</asp:Content>
