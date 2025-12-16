<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="RechercherObjets.aspx.cs" Inherits="prjWebQrFinder.Objetstrouves" EnableEventValidation="false" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        $(document).ready(function () {
            // Basculer entre vue grille et vue liste
            $('.grid-btn').click(function () {
                $('.list-style').hide();
                $('.grid-style').show();
                $('.grid-btn').addClass('active');
                $('.list-btn').removeClass('active');
            });

            $('.list-btn').click(function () {
                $('.grid-style').hide();
                $('.list-style').show();
                $('.list-btn').addClass('active');
                $('.grid-btn').removeClass('active');
            });
        });
    </script>

    <!-- 
=============================================
    Inner Banner
============================================== 
-->

    <div class="inner-banner-one position-relative" style="background: #FF7F00; padding: 80px 0;">
        <div class="container">
            <div class="row align-items-center" style="min-height: 500px;">

                <!-- PARTIE GAUCHE - TEXTE ET FORMULAIRE (50%) -->
                <div class="col-lg-6">
                    <!-- Titre -->
                    <h2 class="text-white fw-bold mb-4" style="font-size: 48px;">Vous avez perdu un objet?</h2>
                    <p class="text-white fs-5 mb-5">Trouvez vos objets perdus en toute simplicité.</p>

                    <!-- Formulaire HORIZONTAL avec Bootstrap -->
                    <div class="bg-white rounded-3 shadow p-3">
                        <div class="row g-2 align-items-end">

                            <!-- Dropdown 1 -->
                            <div class="col-md-5">
                                <%-- <label class="form-label text-muted small mb-1">Qu'est-ce que tu cherches?</label>--%>
                                <asp:DropDownList ID="cboObjets" runat="server" CssClass="form-select border-0 fw-semibold">
                                </asp:DropDownList>
                            </div>

                            <!-- Dropdown 2 -->
                            <div class="col-md-4 border-start ps-3">
                                <%--<label class="form-label text-muted small mb-1">Catégorie</label>--%>
                                <asp:DropDownList ID="cboCategorie" runat="server" CssClass="form-select border-0 fw-semibold">
                                </asp:DropDownList>
                            </div>

                            <!-- Bouton -->
                            <div class="col-md-3">
                                <asp:Button ID="btnChercher" runat="server"
                                    CssClass="btn w-100 fw-bold text-uppercase"
                                    Text="RECHERCHE"
                                    OnClick="btnChercher_Click"
                                    Style="background: #D2F34C; color: #244034; height: 50px;" />
                            </div>

                        </div>
                    </div>
                </div>

                <!-- PARTIE DROITE - IMAGES (50%) -->
                <div class="col-lg-6 d-none d-lg-block">
                    <div class="position-relative" style="height: 450px;">

                        <!-- Image principale -->
                        <img src="images/lazy.svg"
                            data-src="images/assets/ils_01.svg"
                            alt=""
                            class="lazy-img position-absolute bottom-0 end-0"
                            style="width: 85%; z-index: 1;" />

                        <!-- Image screen_01 -->
                        <img src="images/lazy.svg"
                            data-src="images/assets/ils_01_02.svg"
                            alt=""
                            class="lazy-img position-absolute"
                            style="width: 50%; top: 8%; right: 8%; z-index: 2;" />

                        <!-- Image screen_02 -->
                        <img src="images/lazy.svg"
                            data-src="images/assets/ils_01_01.svg"
                            alt=""
                            class="lazy-img position-absolute wow fadeInLeft"
                            style="width: 40%; bottom: 15%; left: 0; z-index: 3;" />

                    </div>
                </div>

            </div>
        </div>
    </div>


    <!-- 
=====================================================
    Objets Trouvés - Section dynamique avec Repeater
============================================== 
-->
    <section class="candidates-profile bg-color pt-90 lg-pt-70 pb-160 xl-pb-150 lg-pb-80">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="position-relative">
                        <!-- Filtres et tri -->
                        <div class="upper-filter d-flex justify-content-between align-items-start align-items-md-center mb-20">
                            <div class="d-md-flex justify-content-between align-items-center">
                                <!-- Bouton filtre qui ouvre le modal -->
                                <button type="button" class="filter-btn fw-500 tran3s me-3"
                                    data-bs-toggle="modal"
                                    data-bs-target="#filterPopUp"
                                    style="background: #FF7F00; color: white; border: none; padding: 10px 20px; border-radius: 5px;">
                                    <i class="bi bi-funnel"></i>Filtrer
                                </button>
                                <div class="total-job-found md-mt-10">
                                    Total <span class="text-dark fw-500">
                                        <asp:Label ID="lblTotalObjets" runat="server">0</asp:Label></span> objets trouvés
                                </div>
                            </div>
                            <div class="d-flex justify-content-between align-items-center">
                                <button class="style-changer-btn text-center rounded-circle tran3s ms-2 list-btn"
                                    title="Vue Liste" style="background: #FF7F00; color: white;">
                                    <i class="bi bi-list"></i>
                                </button>
                                <button class="style-changer-btn text-center rounded-circle tran3s ms-2 grid-btn active"
                                    title="Vue Grille" style="background: #0B1F3A; color: white;">
                                    <i class="bi bi-grid"></i>
                                </button>
                            </div>
                        </div>

                        <!-- GRID STYLE - Repeater pour affichage en grille -->
                        <div class="accordion-box grid-style show">
                            <div class="row">
                                <asp:Repeater ID="rptObjetsTrouvesGrid" runat="server">
                                    <ItemTemplate>
                                        <div class="col-xxl-3 col-lg-4 col-sm-6 d-flex">
                                            <div class="candidate-profile-card text-center grid-layout border-0 mb-25">
                                                <!-- Bouton favori -->
                                                <a href="#" class="save-btn tran3s" style="color: #FF7F00;">
                                                    <i class="bi bi-heart"></i>
                                                </a>

                                                <!-- Image de l'objet -->
                                                <div class="cadidate-avatar position-relative d-block m-auto">
                                                    <a href='ObjetDetails.aspx?id=<%# Eval("ObjetId") %>' class="rounded-circle">
                                                        <img src='<%# Eval("PhotoPrincipale") != DBNull.Value ? Eval("PhotoPrincipale") : "images/objets/default.jpg" %>'
                                                            alt='<%# Eval("Titre") %>'
                                                            class="lazy-img rounded-circle"
                                                            style="width: 120px; height: 120px; object-fit: cover;">
                                                    </a>
                                                </div>

                                                <!-- Nom de l'objet -->
                                                <h4 class="candidate-name mt-15 mb-0">
                                                    <a href='ObjetDetails.aspx?id=<%# Eval("ObjetId") %>' class="tran3s" style="color: #0B1F3A;">
                                                        <%# Eval("Titre") %>
                                                    </a>
                                                </h4>

                                                <!-- Catégorie -->
                                                <div class="candidate-post" style="color: #FF7F00;">
                                                    <i class="<%# Eval("IconeCategorie") %> me-1"></i>
                                                    <%# Eval("NomCategorie") %>
                                                </div>

                                                <!-- Caractéristiques -->
                                                <ul class="cadidate-skills style-none d-flex flex-wrap align-items-center justify-content-center pt-30 sm-pt-20 pb-10">
                                                    <li><%# Eval("Couleur") %></li>
                                                    <li><%# Eval("Marque") != DBNull.Value ? Eval("Marque") : "N/A" %></li>
                                                </ul>

                                                <!-- Informations -->
                                                <div class="row gx-1">
                                                    <div class="col-md-6">
                                                        <div class="candidate-info mt-10">
                                                            <span>Date</span>
                                                            <div><%# Convert.ToDateTime(Eval("DateLocalisation")).ToString("dd MMM yyyy") %></div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="candidate-info mt-10">
                                                            <span>Lieu</span>
                                                            <div><%# Eval("Ville") %></div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Boutons d'action -->
                                                <div class="row gx-2 pt-25 sm-pt-10">
                                                    <div class="col-md-6">
                                                        <a href='ObjetDetails.aspx?id=<%# Eval("ObjetId") %>'
                                                            class="profile-btn tran3s w-100 mt-5"
                                                            style="background: #FF7F00; color: white;">Voir détails
                                                        </a>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <a href='Contact.aspx?objet=<%# Eval("ObjetId") %>'
                                                            class="msg-btn tran3s w-100 mt-5"
                                                            style="background: #0B1F3A; color: white;">Contacter
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <%# (Container.Parent as Repeater).Items.Count == 0 ? 
                                        "<div class='col-12 text-center py-5'><h4>Aucun objet trouvé pour le moment.</h4><p class='text-muted'>Revenez plus tard ou modifiez vos critères de recherche.</p></div>" : "" %>
                                    </FooterTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                        <!-- /.grid-style -->

                        <!-- LIST STYLE - Repeater pour affichage en liste -->
                        <div class="accordion-box list-style" style="display: none;">
                            <asp:Repeater ID="rptObjetsTrouvesList" runat="server">
                                <ItemTemplate>
                                    <div class="candidate-profile-card list-layout border-0 mb-25">
                                        <div class="d-flex">
                                            <!-- Image -->
                                            <div class="cadidate-avatar position-relative d-block me-auto ms-auto">
                                                <a href='ObjetDetails.aspx?id=<%# Eval("ObjetId") %>' class="rounded-circle">
                                                    <img src='<%# Eval("PhotoPrincipale") != DBNull.Value ? Eval("PhotoPrincipale") : "images/objets/default.jpg" %>'
                                                        alt='<%# Eval("Titre") %>'
                                                        class="lazy-img rounded-circle"
                                                        style="width: 100px; height: 100px; object-fit: cover;">
                                                </a>
                                            </div>

                                            <!-- Informations -->
                                            <div class="right-side">
                                                <div class="row gx-1">
                                                    <div class="col-xl-4">
                                                        <div class="position-relative">
                                                            <h4 class="candidate-name mb-0">
                                                                <a href='ObjetDetails.aspx?id=<%# Eval("ObjetId") %>'
                                                                    class="tran3s" style="color: #0B1F3A;">
                                                                    <%# Eval("Titre") %>
                                                                </a>
                                                            </h4>
                                                            <div class="candidate-post" style="color: #FF7F00;">
                                                                <%# Eval("NomCategorie") %>
                                                            </div>
                                                            <ul class="cadidate-skills style-none d-flex align-items-center">
                                                                <li><%# Eval("Couleur") %></li>
                                                                <li><%# Eval("Marque") != DBNull.Value ? Eval("Marque") : "N/A" %></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                    <div class="col-xl-3 col-md-4 col-sm-6">
                                                        <div class="candidate-info mt-10">
                                                            <span>Date trouvé</span>
                                                            <div><%# Convert.ToDateTime(Eval("DateLocalisation")).ToString("dd MMM yyyy") %></div>
                                                        </div>
                                                    </div>
                                                    <div class="col-xl-3 col-md-4 col-sm-6">
                                                        <div class="candidate-info mt-10">
                                                            <span>Lieu</span>
                                                            <div><%# Eval("Lieu") %>, <%# Eval("Ville") %></div>
                                                        </div>
                                                    </div>
                                                    <div class="col-xl-2 col-md-4">
                                                        <div class="d-flex justify-content-lg-end">
                                                            <a href="#" class="save-btn text-center rounded-circle tran3s mt-10"
                                                                style="color: #FF7F00;">
                                                                <i class="bi bi-heart"></i>
                                                            </a>
                                                            <a href='ObjetDetails.aspx?id=<%# Eval("ObjetId") %>'
                                                                class="profile-btn tran3s ms-md-2 mt-10 sm-mt-20"
                                                                style="background: #FF7F00; color: white;">Voir détails
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <%# (Container.Parent as Repeater).Items.Count == 0 ? 
                                    "<div class='text-center py-5'><h4>Aucun objet trouvé.</h4></div>" : "" %>
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>
                        <!-- /.list-style -->

                        <!-- Pagination -->
                        <div class="pt-20 d-sm-flex align-items-center justify-content-between">
                            <p class="m0 order-sm-last text-center text-sm-start xs-pb-20">
                                Affichage de <span class="text-dark fw-500">
                                    <asp:Label ID="lblDebut" runat="server">1</asp:Label></span>
                                à <span class="text-dark fw-500">
                                    <asp:Label ID="lblFin" runat="server">20</asp:Label></span>
                                sur <span class="text-dark fw-500">
                                    <asp:Label ID="lblTotal" runat="server">0</asp:Label></span>
                            </p>
                            <div class="d-flex justify-content-center">
                                <ul class="pagination-two d-flex align-items-center style-none">
                                    <li class="active"><a href="#" style="background: #FF7F00; color: white;">1</a></li>
                                    <li><a href="#" style="color: #0B1F3A;">2</a></li>
                                    <li><a href="#" style="color: #0B1F3A;">3</a></li>
                                    <li><a href="#" style="color: #0B1F3A;"><i class="bi bi-chevron-right"></i></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!--
=====================================================
QRFINDER Portal Intro - Section Principale
=====================================================
-->
    <section class="qrfinder-intro-section py-5">
        <div class="container">
            <div class="row align-items-center g-4">
                <!-- Partie gauche : Titre + Description + Stats -->
                <div class="col-lg-7">
                    <div class="text-center text-lg-start">
                        <h1 class="fw-bold mb-3">
                            <i class="bi bi-qr-code text-primary"></i>QRFinder
                        </h1>
                        <h2 class="h3 mb-3">Retrouvez vos objets perdus facilement</h2>
                        <p class="lead mb-4">
                            La plateforme communautaire qui utilise les codes QR pour vous aider 
                        à retrouver vos objets perdus et à restituer ceux que vous trouvez.
                        </p>

                        <!-- Statistiques en direct -->
                        <div class="row g-3 mb-3">
                            <div class="col-4">
                                <div class="stat-card text-center p-3 bg-white rounded shadow-sm">
                                    <i class="bi bi-exclamation-circle text-danger fs-3"></i>
                                    <h3 class="fs-4 fw-bold text-danger mb-0"><%= GetStatObjetsPerdus() %></h3>
                                    <small class="text-muted">Objets perdus</small>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="stat-card text-center p-3 bg-white rounded shadow-sm">
                                    <i class="bi bi-check-circle text-success fs-3"></i>
                                    <h3 class="fs-4 fw-bold text-success mb-0"><%= GetStatObjetsTrouves() %></h3>
                                    <small class="text-muted">Objets trouvés</small>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="stat-card text-center p-3 bg-white rounded shadow-sm">
                                    <i class="bi bi-people text-info fs-3"></i>
                                    <h3 class="fs-4 fw-bold text-info mb-0"><%= GetStatMembres() %></h3>
                                    <small class="text-muted">Membres actifs</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Partie droite : Actions principales -->
                <div class="col-lg-5">
                    <div class="action-buttons">
                        <!-- Rechercher un objet perdu -->
                        <div class="mb-3">
                            <a href="rechercherObjets.aspx" class="btn btn-lg btn-primary w-100 d-flex align-items-center justify-content-center shadow">
                                <i class="bi bi-search me-2 fs-5"></i>
                                <div class="text-start">
                                    <div class="fw-bold">Rechercher un objet</div>
                                    <small class="d-block opacity-75">J'ai perdu quelque chose</small>
                                </div>
                            </a>
                        </div>

                        <!-- Déclarer un objet trouvé -->
                        <div class="mb-3">
                            <a href="declarerObjet.aspx" class="btn btn-lg btn-success w-100 d-flex align-items-center justify-content-center shadow">
                                <i class="bi bi-plus-circle me-2 fs-5"></i>
                                <div class="text-start">
                                    <div class="fw-bold">Déclarer un objet</div>
                                    <small class="d-block opacity-75">J'ai trouvé quelque chose</small>
                                </div>
                            </a>
                        </div>

                        <!-- Scanner un QR Code -->
                        <div class="mb-3">
                            <a href="scannerQR.aspx" class="btn btn-lg btn-outline-dark w-100 d-flex align-items-center justify-content-center">
                                <i class="bi bi-qr-code-scan me-2 fs-5"></i>
                                <div class="text-start">
                                    <div class="fw-bold">Scanner un QR Code</div>
                                    <small class="d-block opacity-75">Identifier un objet trouvé</small>
                                </div>
                            </a>
                        </div>

                        <!-- Enregistrer mes objets (pour utilisateurs connectés) -->
                        <% if (Session["MembreId"] != null)
                            { %>
                        <div>
                            <a href="mesObjets.aspx" class="btn btn-link w-100 text-center">
                                <i class="bi bi-box me-1"></i>Gérer mes objets enregistrés
                            </a>
                        </div>
                        <% }
                            else
                            { %>
                        <div class="text-center mt-3">
                            <p class="mb-2 text-muted">Pas encore membre ?</p>
                            <a href="inscriptionQrFinder.aspx" class="btn btn-outline-primary">
                                <i class="bi bi-person-plus me-1"></i>Créer un compte gratuit
                            </a>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- /.job-portal-intro -->

    <!-- Modal -->
    
        <!-- Modal Filtre pour Objets Trouvés -->
        <div class="modal popUpModal fade" id="filterPopUp" tabindex="-1" aria-labelledby="filterModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-fullscreen modal-dialog-centered">
                <div class="container">
                    <div class="filter-area-tab modal-content">
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>

                        <div class="position-relative">
                            <!-- Titre -->
                            <div class="main-title fw-500 text-dark ps-4 pe-4 pt-15 pb-15 border-bottom"
                                style="background: #FF7F00; color: white !important;">
                                <i class="bi bi-funnel me-2"></i>Filtrer les objets trouvés
                            </div>

                            <!-- Contenu des filtres -->
                            <asp:Panel ID="pnlFiltres" runat="server" CssClass="pt-25 pb-30 ps-4 pe-4">
                                <div class="row">
                                    <!-- Mot-clé -->
                                    <div class="col-lg-3">
                                        <div class="filter-block pb-50 md-pb-20">
                                            <div class="filter-title fw-500 text-dark mb-2">
                                                <i class="bi bi-search" style="color: #FF7F00;"></i>Mot-clé
                                            </div>
                                            <div class="input-box position-relative">
                                                <asp:TextBox ID="txtMotCle" runat="server"
                                                    placeholder="Ex: iPhone, portefeuille..."
                                                    CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Catégorie -->
                                    <div class="col-lg-3">
                                        <div class="filter-block pb-50 md-pb-20">
                                            <div class="filter-title fw-500 text-dark mb-2">
                                                <i class="bi bi-grid" style="color: #FF7F00;"></i>Catégorie
                                            </div>
                                            <asp:DropDownList ID="cboCategorieFiltre" runat="server" CssClass="form-select">
                                            </asp:DropDownList>
                                        </div>
                                    </div>

                                    <!-- Ville -->
                                    <div class="col-lg-3">
                                        <div class="filter-block pb-50 md-pb-20">
                                            <div class="filter-title fw-500 text-dark mb-2">
                                                <i class="bi bi-geo-alt" style="color: #FF7F00;"></i>Ville
                                            </div>
                                                <%-- A ameliorer --%>
                                            <asp:DropDownList ID="cboVilleFiltre" runat="server" CssClass="form-select">
                                                <asp:ListItem Value="">Toutes les villes</asp:ListItem>
                                                <asp:ListItem Value="Montreal">Montréal</asp:ListItem>
                                                <asp:ListItem Value="Quebec">Québec</asp:ListItem>
                                                <asp:ListItem Value="Laval">Laval</asp:ListItem>
                                                <asp:ListItem Value="Gatineau">Gatineau</asp:ListItem>
                                                <asp:ListItem Value="Longueuil">Longueuil</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>

                                    <!-- Couleur -->
                                    <div class="col-lg-3">
                                        <div class="filter-block pb-50 md-pb-20">
                                            <div class="filter-title fw-500 text-dark mb-2">
                                                <i class="bi bi-palette" style="color: #FF7F00;"></i>Couleur
                                            </div>
                                            <%-- A ameliorer --%>
                                            <asp:DropDownList ID="cboCouleurFiltre" runat="server" CssClass="form-select">
                                                <asp:ListItem Value="">Toutes</asp:ListItem>
                                                <asp:ListItem Value="Noir">Noir</asp:ListItem>
                                                <asp:ListItem Value="Blanc">Blanc</asp:ListItem>
                                                <asp:ListItem Value="Rouge">Rouge</asp:ListItem>
                                                <asp:ListItem Value="Bleu">Bleu</asp:ListItem>
                                                <asp:ListItem Value="Vert">Vert</asp:ListItem>
                                                <asp:ListItem Value="Jaune">Jaune</asp:ListItem>
                                                <asp:ListItem Value="Gris">Gris</asp:ListItem>
                                                <asp:ListItem Value="Rose">Rose</asp:ListItem>
                                                <asp:ListItem Value="Marron">Marron</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>

                                <!-- Deuxième ligne de filtres -->
                                <div class="row">
                                    <!-- Période -->
                                    <div class="col-lg-6">
                                        <div class="filter-block pb-25">
                                            <div class="filter-title fw-500 text-dark mb-2">
                                                <i class="bi bi-calendar" style="color: #FF7F00;"></i>Période
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <label class="small text-muted">Date début</label>
                                                    <asp:TextBox ID="txtDateDebut" runat="server"
                                                        TextMode="Date"
                                                        CssClass="form-control"></asp:TextBox>
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="small text-muted">Date fin</label>
                                                    <asp:TextBox ID="txtDateFin" runat="server"
                                                        TextMode="Date"
                                                        CssClass="form-control"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Marque -->
                                    <div class="col-lg-3">
                                        <div class="filter-block pb-25">
                                            <div class="filter-title fw-500 text-dark mb-2">
                                                <i class="bi bi-tag" style="color: #FF7F00;"></i>Marque
                                            </div>
                                            <asp:TextBox ID="txtMarqueFiltre" runat="server"
                                                placeholder="Ex: Apple, Samsung..."
                                                CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>

                                    <!-- Statut -->
                                    <div class="col-lg-3">
                                        <div class="filter-block pb-25">
                                            <div class="filter-title fw-500 text-dark mb-2">
                                                <i class="bi bi-check-circle" style="color: #0B1F3A;"></i>Statut
                                            </div>
                                            <asp:DropDownList ID="CboStatutFiltre" runat="server" CssClass="form-select">
                                                <asp:ListItem Value="">Tous les statuts</asp:ListItem>
                                                <asp:ListItem Value="Trouvé">Trouvé</asp:ListItem>
                                                <asp:ListItem Value="En cours de restitution">En cours</asp:ListItem>
                                                <asp:ListItem Value="Restitué">Restitué</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>

                                <!-- Boutons d'action -->
                                <div class="row mt-3">
                                    <div class="col-lg-6 mx-auto">
                                        <div class="row g-2">
                                            <div class="col-6">
                                                <asp:Button ID="btnAppliquerFiltre" runat="server"
                                                    Text="Appliquer les filtres"
                                                    CssClass="btn w-100 fw-500 text-white"
                                                    Style="background: #FF7F00; border: none;"
                                                    OnClick="btnAppliquerFiltre_Click" />
                                            </div>
                                            <div class="col-6">
                                                <asp:Button ID="btnReinitialiser" runat="server"
                                                    Text="Réinitialiser"
                                                    CssClass="btn w-100 fw-500"
                                                    Style="background: white; color: #0B1F3A; border: 2px solid #0B1F3A;"
                                                    OnClick="btnReinitialiser_Click" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                </div>
            </div>
        </div>

   
    <button class="scroll-top">
        <i class="bi bi-arrow-up-short"></i>
    </button>
</asp:Content>
