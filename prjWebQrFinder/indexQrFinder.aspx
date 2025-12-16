<%@ Page Language="C#" Title="" AutoEventWireup="true" MasterPageFile="~/MasterPageIndex.Master" CodeBehind="indexQrFinder.aspx.cs" Inherits="prjWebQrFinder.indexFinder" %>

<asp:Content ID="ContentMain" ContentPlaceHolderID="MainContent" runat="server">
    <style type="text/css">
       /* Animation au scroll */
.etape-animee {
  opacity: 0;
  transform: translateY(40px);
  transition: all 0.6s ease-out;
}
.etape-animee.visible {
  opacity: 1;
  transform: translateY(0);
}

/* Titre principal */
h2 {
  color: #FF7F00;
}

/* Carte membre */
.team-card {
  background-color: #fff;
  border: none;
  box-shadow: none;
  transition: transform 0.3s ease;
}
.team-card:hover {
  transform: translateY(-6px);
  box-shadow: 0 0.75rem 1.5rem rgba(0, 0, 0, 0.1);
}

/* Image membre centrée */
.member-img img {
  width: 100px;
  height: 100px;
  object-fit: cover;
  border-radius: 50%;
  margin: 0 auto;
  display: block;
}

/* Couleur principale des textes */
.text-brand {
  color: #0B1F3A;
}

/* Supprimer soulignement des noms */
.no-underline {
  text-decoration: none;
}

/* Icône LinkedIn stylisée */
.linkedin-icon {
  display: inline-block;
  background-color: #FF7F00;
  color: #fff;
  border-radius: 50%;
  padding: 8px;
  font-size: 1.2rem;
  line-height: 1;
  transition: background-color 0.3s ease;
}
.linkedin-icon:hover {
  background-color: #e66f00;
  text-decoration: none;
}
    </style>
    <main>
        <!-- Section Hero -->
        <section class="row align-items-center py-5">
            <div class="col-md-6">
                <h2 class="mb-3">RETROUVEZ VOS OBJETS PERDUS<br />
                    GRÂCE AUX QR CODES</h2>
                <p>QR Finder vous aide à signaler et retrouver facilement les objets perdus ou trouvés.</p>
                <p>Connectez les gens à leurs affaires en un clic.</p>
                <div class="d-flex gap-3 mt-4">
                    <asp:Button ID="btnTrouver" runat="server" Text="J'ai trouvé" CssClass="btn btn-success" />
                    <asp:Button ID="btnPerdu" runat="server" Text="J'ai perdu" CssClass="btn btn-outline-primary" />
                </div>
            </div>
            <div class="col-md-6 text-center">
                <img src="mesImages/objet.png" alt="QR Finder illustration" class="img-fluid" />
            </div>
        </section>

        <!-- Section Fonctionnement -->
        <section class="py-5 bg-light">
            <div class="container">
                <h2 class="text-center mb-5">Comment ça marche QR Finder ?</h2>
                <div class="row g-4">
                    <!-- Étape 1 -->
                    <div class="col-md-3">
                        <div class="card text-center border-0 shadow-sm etape-animee">
                            <div class="card-body">
                                <i class="bi bi-pencil-square fs-1 mb-3 text-primary"></i>
                                <h5 class="card-title">Signaler un objet</h5>
                                <p class="card-text">Décrivez-le dans un formulaire : nom, type, couleur, lieu...</p>
                            </div>
                        </div>
                    </div>

                    <!-- Étape 2 -->
                    <div class="col-md-3">
                        <div class="card text-center border-0 shadow-sm etape-animee">
                            <div class="card-body">
                                <i class="bi bi-search fs-1 mb-3 text-info"></i>
                                <h5 class="card-title">Rechercher rapidement</h5>
                                <p class="card-text">Utilisez nos filtres pour localiser un objet en quelques secondes.</p>
                            </div>
                        </div>
                    </div>

                    <!-- Étape 3 -->
                    <div class="col-md-3">
                        <div class="card text-center border-0 shadow-sm etape-animee">
                            <div class="card-body">
                                <i class="bi bi-shield-check fs-1 mb-3 text-success"></i>
                                <h5 class="card-title">Récupérer en sécurité</h5>
                                <p class="card-text">Contactez le trouveur via la plateforme, sans exposer vos données.</p>
                            </div>
                        </div>
                    </div>

                    <!-- Étape 4 -->
                    <div class="col-md-3">
                        <div class="card text-center border-0 shadow-sm etape-animee">
                            <div class="card-body">
                                <i class="bi bi-qr-code fs-1 mb-3 text-warning"></i>
                                <h5 class="card-title">Option QR code</h5>
                                <p class="card-text">Générez un QR code unique pour chaque objet et facilitez son retour.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        
         <!-- QR Finder en action-->
        <section class="py-5 bg-white">
  <div class="container">
    <h2 class="text-center mb-5">QR Finder en action</h2>
    <div class="row g-4">
      <!-- Carte 1 -->
      <div class="col-md-4">
        <div class="card qr-card h-100 border-0 shadow-sm overflow-hidden">
          <img src="mesImages/perdu.png" alt="Objet perdu" class="card-img-top full-image" />
          <div class="card-body text-center d-flex flex-column justify-content-between">
            <h5 class="card-title mb-2">OBJETS PERDUS</h5>
            <p class="card-text mb-0">
              Avec <strong>QR Finder</strong>, plusieurs objets perdus peuvent être enregistrés et retrouvés grâce à nos QR codes intelligents.
            </p>
          </div>
        </div>
      </div>

      <!-- Carte 2 : icône QR simulée comme image -->
      <div class="col-md-4">
        <div class="card qr-card h-100 border-0 shadow-sm overflow-hidden">
          <div class="card-img-top full-image d-flex justify-content-center align-items-center">
            <i class="bi bi-qr-code fs-1 text-dark"></i>
          </div>
          <div class="card-body text-center d-flex flex-column justify-content-between">
            <h5 class="card-title mb-2">Recherche simplifiée</h5>
            <p class="card-text mb-0">
              QR Finder transforme la recherche d’objets perdus en une expérience simple : scannez un QR code et retrouvez rapidement l’objet.
            </p>
          </div>
        </div>
      </div>

      <!-- Carte 3 -->
      <div class="col-md-4">
        <div class="card qr-card h-100 border-0 shadow-sm overflow-hidden">
          <img src="mesImages/images.png" alt="Partage communautaire" class="card-img-top full-image" />
          <div class="card-body text-center d-flex flex-column justify-content-between">
            <h5 class="card-title mb-2">Un objet perdu ?</h5>
            <p class="card-text mb-0">
              Grâce à <strong>QR Finder</strong>, les habitants peuvent signaler et retrouver des objets perdus dans leur ville en quelques clics. Un service innovant pour tous.
            </p>
          </div>
        </div>
      </div>
    </div>
  </div>      
</section>
        <!-- Section Membres du projet -->

  <section class="jumbotron mb-0 bg-white jumbotron-fluid">
  <div class="container-fluid">
    <div class="pb-4">
      <h2 data-sal="slide-up" data-sal-duration="500" class="text-center text-uppercase title-font">
        Membres du projet
      </h2>
    </div>
    <div class="row justify-content-center align-items-center">

      <!-- Eric Beda -->
      <div class="col-sm-6 col-lg-4">
        <div data-sal="slide-up" data-sal-duration="500" class="card team-card hover-shadow mx-auto" style="width: 300px;">
          <div class="card-body py-4 text-center">
            <div class="member-img mb-3">
              <img src="mesImages/beda.jpg" alt="Eric Beda" class="img-fluid rounded-circle" />
            </div>
            <h3 class="card-title text-uppercase h4 mb-2">
              <a href="https://linkedin.com/in/beda225" target="_blank" class="no-underline text-brand title-font">
                Eric Beda
              </a>
            </h3>
            <p class="card-text mb-2">
              <span class="font-weight-bold text-brand">Co-Fondateur</span><br>
              <a href="mailto:a.anazet1@gmail.com" class="text-brand font-weight-light">a.anazet1@gmail.com</a>
            </p>
            <p class="card-text">
              <a href="https://linkedin.com/in/beda225" target="_blank" class="linkedin-icon" aria-label="linkedin Eric Beda">
                <i class="bi bi-linkedin"></i>
              </a>
            </p>
          </div>
        </div>
      </div>

      <!-- Fama Djigo -->
      <div class="col-sm-6 col-lg-4">
        <div data-sal="slide-up" data-sal-duration="500" class="card team-card hover-shadow mx-auto" style="width: 300px;">
          <div class="card-body py-4 text-center">
            <div class="member-img mb-3">
              <img src="mesImages/fama.jpg" alt="Fama Djigo" class="img-fluid rounded-circle" />
            </div>
            <h3 class="card-title text-uppercase h4 mb-2">
              <a href="https://linkedin.com/in/fama-djigo-01a104255" target="_blank" class="no-underline text-brand title-font">
                Fama Djigo
              </a>
            </h3>
            <p class="card-text mb-2">
              <span class="font-weight-bold text-brand">Co-Fondatrice</span><br>
              <a href="mailto:famadjigo@gmail.com" class="text-brand font-weight-light">famadjigo@gmail.com</a>
            </p>
            <p class="card-text">
              <a href="https://linkedin.com/in/fama-djigo-01a104255" target="_blank" class="linkedin-icon" aria-label="linkedin Fama Djigo">
                <i class="bi bi-linkedin"></i>
              </a>
            </p>
          </div>
        </div>
      </div>

    </div>
  </div>
</section>

        
    </main>
    <script>
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('visible');
                }
            });
        }, { threshold: 0.2 });

        document.querySelectorAll('.etape-animee').forEach(el => {
            observer.observe(el);
        });
    </script>

</asp:Content>
