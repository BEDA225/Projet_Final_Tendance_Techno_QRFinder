<%@ Page Language="C#" Title="Acceuil" MasterPageFile="~/MasterPageAccueilUser.master" AutoEventWireup="true" CodeBehind="accueilUtilisateursQrFinder.aspx.cs" Inherits="prjWebQrFinder.accueilUtilisateurs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style type="text/css">
        .dasboard-main-nav ul li a:hover i {
            transform: scale(1.1);
            transition: all 0.3s ease;
        }

        .dasboard-main-nav ul li a.active {
            background: rgba(255, 127, 0, 0.1);
            border-left: 3px solid #FF7F00;
        }

            .dasboard-main-nav ul li a.active i {
                color: #FF7F00 !important;
            }
    </style>


    <aside class="dash-aside-navbar">
        <div class="position-relative">
            <div class="logo text-md-center d-md-block d-flex align-items-center justify-content-between">
                <a href="accueilUtilisateursQrFinder.aspx">
                    <img src="images/logo_01.png" alt="QRFinder">
                </a>
                <button class="close-btn d-block d-md-none"><i class="bi bi-x-lg"></i></button>
            </div>
            <div class="user-data">
                <div class="user-avatar online position-relative rounded-circle">
                    <img src="images/lazy.svg" data-src="images/avatar_01.jpg" alt="" class="lazy-img">
                </div>
                <div class="user-name-data">
                    <button class="user-name dropdown-toggle" type="button" id="profile-dropdown" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false">
                        <asp:Label ID="lblNomUtilisateur" runat="server"></asp:Label>
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="profile-dropdown">
                        <li>
                            <a class="dropdown-item d-flex align-items-center" href="dashboard-profile.aspx">
                                <img src="images/lazy.svg" data-src="images/icon/icon_23.svg" alt="" class="lazy-img">
                                <span class="ms-2 ps-1">Mon Profil</span>
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item d-flex align-items-center" href="dashboard-settings.aspx">
                                <img src="images/lazy.svg" data-src="images/icon/icon_24.svg" alt="" class="lazy-img">
                                <span class="ms-2 ps-1">Paramètres du compte</span>
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item d-flex align-items-center" href="dashboard-alert.aspx">
                                <img src="images/lazy.svg" data-src="images/icon/icon_25.svg" alt="" class="lazy-img">
                                <span class="ms-2 ps-1">Notifications</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

            <nav class="dasboard-main-nav">
                <ul class="style-none">
                    <li>
                        <a href="accueilUtilisateursQrFinder.aspx" class="d-flex w-100 align-items-center active">
                            <i class="bi bi-speedometer2 fs-5 me-2" style="color: #FF7F00;"></i>
                            <span>Tableau de bord</span>
                        </a>
                    </li>
                    <li>
                        <a href="dashboard-profile.aspx" class="d-flex w-100 align-items-center">
                            <i class="bi bi-person-circle fs-5 me-2" style="color: #0B1F3A;"></i>
                            <span>Mon Profil</span>
                        </a>
                    </li>
                    <li>
                        <a href="MesObjets.aspx" class="d-flex w-100 align-items-center">
                            <i class="bi bi-box-seam fs-5 me-2" style="color: #FF7F00;"></i>
                            <span>Mes Objets</span>
                        </a>
                    </li>
                    <li>
                        <a href="DeclarerObjets.aspx" class="d-flex w-100 align-items-center">
                            <i class="bi bi-plus-circle fs-5 me-2" style="color: #0B1F3A;"></i>
                            <span>Déclarer un objet</span>
                        </a>
                    </li>
                    <li>
                        <a href="Objetstrouves.aspx" class="d-flex w-100 align-items-center">
                            <i class="bi bi-search fs-5 me-2" style="color: #FF7F00;"></i>
                            <span>Rechercher</span>
                        </a>
                    </li>
                    <li>
                        <a href="dashboard-message.aspx" class="d-flex w-100 align-items-center">
                            <i class="bi bi-chat-dots fs-5 me-2" style="color: #0B1F3A;"></i>
                            <span>Messages</span>
                        </a>
                    </li>
                    <li>
                        <a href="dashboard-alert.aspx" class="d-flex w-100 align-items-center">
                            <i class="bi bi-bell fs-5 me-2" style="color: #FF7F00;"></i>
                            <span>Alertes</span>
                        </a>
                    </li>
                    <li>
                        <a href="dashboard-settings.aspx" class="d-flex w-100 align-items-center">
                            <i class="bi bi-gear fs-5 me-2" style="color: #0B1F3A;"></i>
                            <span>Paramètres</span>
                        </a>
                    </li>
                    <li>
                        <a href="#" class="d-flex w-100 align-items-center" data-bs-toggle="modal" data-bs-target="#deleteModal">
                            <i class="bi bi-trash fs-5 me-2" style="color: #FF7F00;"></i>
                            <span>Supprimer le compte</span>
                        </a>
                    </li>
                </ul>
            </nav>

            <asp:LinkButton ID="btnDeconnexion" runat="server" OnClick="btnDeconnexion_Click" CssClass="d-flex w-100 align-items-center logout-btn">
                <img src="images/lazy.svg" data-src="images/icon/icon_9.svg" alt="" class="lazy-img">
                <span>Se déconnecter</span>
            </asp:LinkButton>
        </div>
    </aside>

    <div class="dashboard-body">
        <div class="position-relative">
            <!-- Header -->
            <header class="dashboard-header">
                <div class="d-flex align-items-center justify-content-end">
                    <button class="dash-mobile-nav-toggler d-block d-md-none me-auto">
                        <span></span>
                    </button>
                    <div class="search-form">
                        <asp:TextBox ID="txtRecherche" runat="server" placeholder="Rechercher un objet..." CssClass="form-control"></asp:TextBox>
                        <button>
                            <img src="images/lazy.svg" data-src="images/icon/icon_10.svg" alt="" class="lazy-img m-auto"></button>
                    </div>
                    <div class="profile-notification ms-2 ms-md-5 me-4">
                        <button class="noti-btn dropdown-toggle" type="button" id="notification-dropdown" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false">
                            <img src="images/lazy.svg" data-src="images/icon/icon_11.svg" alt="" class="lazy-img">
                            <div class="badge-pill"></div>
                        </button>
                        <ul class="dropdown-menu" aria-labelledby="notification-dropdown">
                            <li>
                                <h4>Notifications</h4>
                                <ul class="style-none notify-list">
                                    <asp:Repeater ID="rptNotifications" runat="server">
                                        <ItemTemplate>
                                            <li class="d-flex align-items-center <%# Eval("Lu").ToString() == "False" ? "unread" : "" %>">
                                                <img src="images/lazy.svg" data-src="images/icon/icon_36.svg" alt="" class="lazy-img icon">
                                                <div class="flex-fill ps-2">
                                                    <h6><%# Eval("Message") %></h6>
                                                    <span class="time"><%# Eval("DateNotification") %></span>
                                                </div>
                                            </li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ul>
                            </li>
                        </ul>
                    </div>
                    <div>
                        <a href="DeclarerObjets.aspx" class="job-post-btn tran3s" style="background: #FF7F00;">
                            <i class="bi bi-plus-circle me-2"></i>Déclarer un objet
                        </a>
                    </div>
                </div>
            </header>

            <h2 class="main-title">Tableau de bord</h2>

            <!-- Statistiques -->
            <div class="row">
                <div class="col-lg-3 col-6">
                    <div class="dash-card-one bg-white border-30 position-relative mb-15">
                        <div class="d-sm-flex align-items-center justify-content-between">
                            <div class="icon rounded-circle d-flex align-items-center justify-content-center order-sm-1" style="background: rgba(255, 127, 0, 0.1);">
                                <i class="bi bi-exclamation-circle fs-3" style="color: #FF7F00;"></i>
                            </div>
                            <div class="order-sm-0">
                                <div class="value fw-500">
                                    <asp:Label ID="lblObjetsPerdu" runat="server">0</asp:Label>
                                </div>
                                <span>Objets Perdus</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-6">
                    <div class="dash-card-one bg-white border-30 position-relative mb-15">
                        <div class="d-sm-flex align-items-center justify-content-between">
                            <div class="icon rounded-circle d-flex align-items-center justify-content-center order-sm-1" style="background: rgba(11, 31, 58, 0.1);">
                                <i class="bi bi-check-circle fs-3" style="color: #0B1F3A;"></i>
                            </div>
                            <div class="order-sm-0">
                                <div class="value fw-500">
                                    <asp:Label ID="lblObjetsTrouves" runat="server">0</asp:Label>
                                </div>
                                <span>Objets Trouvés</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-6">
                    <div class="dash-card-one bg-white border-30 position-relative mb-15">
                        <div class="d-sm-flex align-items-center justify-content-between">
                            <div class="icon rounded-circle d-flex align-items-center justify-content-center order-sm-1" style="background: rgba(76, 175, 80, 0.1);">
                                <i class="bi bi-arrow-repeat fs-3 text-success"></i>
                            </div>
                            <div class="order-sm-0">
                                <div class="value fw-500">
                                    <asp:Label ID="lblObjetsRestitues" runat="server">0</asp:Label>
                                </div>
                                <span>Objets Restitués</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-6">
                    <div class="dash-card-one bg-white border-30 position-relative mb-15">
                        <div class="d-sm-flex align-items-center justify-content-between">
                            <div class="icon rounded-circle d-flex align-items-center justify-content-center order-sm-1" style="background: rgba(33, 150, 243, 0.1);">
                                <i class="bi bi-qr-code fs-3 text-primary"></i>
                            </div>
                            <div class="order-sm-0">
                                <div class="value fw-500">
                                    <asp:Label ID="lblCodesQR" runat="server">0</asp:Label>
                                </div>
                                <span>Codes QR actifs</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row d-flex pt-50 lg-pt-10">
                <!-- Graphique d'activité -->
                <div class="col-xl-7 col-lg-6 d-flex flex-column">
                    <div class="user-activity-chart bg-white border-20 mt-30 h-100">
                        <h4 class="dash-title-two">Activité récente</h4>
                        <div class="ps-5 pe-5 mt-50">
                            <canvas id="activityChart"></canvas>
                        </div>
                    </div>
                </div>

                <!-- Objets enregistrés récents -->
                <div class="col-xl-5 col-lg-6 d-flex">
                    <div class="recent-job-tab bg-white border-20 mt-30 w-100">
                        <h4 class="dash-title-two">Mes Objets Récents</h4>
                        <div class="wrapper">
                            <asp:Repeater ID="rptObjetsRecents" runat="server">
                                <ItemTemplate>
                                    <div class="job-item-list d-flex align-items-center">
                                        <div>
                                            <img src='<%# Eval("PhotoPrincipale") != DBNull.Value ? Eval("PhotoPrincipale") : "images/objets/default.jpg" %>'
                                                alt='<%# Eval("Titre") %>'
                                                class="lazy-img logo"
                                                style="width: 50px; height: 50px; object-fit: cover; border-radius: 8px;">
                                        </div>
                                        <div class="job-title">
                                            <h6 class="mb-5">
                                                <a href='ObjetDetails.aspx?id=<%# Eval("ObjetId") %>'><%# Eval("Titre") %></a>
                                            </h6>
                                            <div class="meta">
                                                <span class="badge" style='background: <%# Eval("TypeDeclaration").ToString() == "Perdu" ? "#FF7F00" : "#0B1F3A" %>; color: white;'>
                                                    <%# Eval("TypeDeclaration") %>
                                                </span>
                                                <span><%# Eval("Ville") %></span>
                                            </div>
                                        </div>
                                        <div class="job-action">
                                            <button class="action-btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                <span></span>
                                            </button>
                                            <ul class="dropdown-menu">
                                                <li><a class="dropdown-item" href='ObjetDetails.aspx?id=<%# Eval("ObjetId") %>'>Voir détails</a></li>
                                                <li><a class="dropdown-item" href='EditObjet.aspx?id=<%# Eval("ObjetId") %>'>Modifier</a></li>
                                                <li><a class="dropdown-item" href='#' onclick='return confirm("Voulez-vous vraiment supprimer cet objet?");'>Supprimer</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <%# (Container.Parent as Repeater).Items.Count == 0 ? 
                                        "<div class='text-center py-4'><p class='text-muted'>Aucun objet enregistré pour le moment.</p><a href='DeclarerObjets.aspx' class='btn btn-primary' style='background: #FF7F00; border: none;'>Déclarer un objet</a></div>" : "" %>
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Suppression de compte -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-fullscreen modal-dialog-centered">
            <div class="container">
                <div class="remove-account-popup text-center modal-content">
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    <img src="images/lazy.svg" data-src="images/icon/icon_22.svg" alt="" class="lazy-img m-auto">
                    <h2>Êtes-vous sûr ?</h2>
                    <p>Voulez-vous vraiment supprimer votre compte ? Toutes vos données seront perdues.</p>
                    <div class="button-group d-inline-flex justify-content-center align-items-center pt-15">
                        <asp:Button ID="btnConfirmerSuppression" runat="server" Text="Oui, supprimer"
                            CssClass="confirm-btn fw-500 tran3s me-3"
                            OnClick="btnConfirmerSuppression_Click"
                            OnClientClick="return confirm('Cette action est irréversible. Continuer ?');" />
                        <button type="button" class="btn-close fw-500 ms-3" data-bs-dismiss="modal" aria-label="Close">Annuler</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

