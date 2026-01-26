\NeedsTeXFormat{LaTeX2e}
 
\ProvidesClass{edgemind-minutes}[2014/07/09, EdgeMind Minutes, V1.0]
% Classe cdc-retd-mri
%
% Modèle pour la rédaction de cahier des charges EDF R&D MRI en LaTeX.
%

\LoadClass[a4paper, 11pt]{article}

\RequirePackage[default,scale=0.95]{opensans}
\RequirePackage[T1]{fontenc}
\RequirePackage{supertabular}
\RequirePackage{array}
\RequirePackage{tabularx}
\RequirePackage{longtable}
\RequirePackage{colortbl} 
\RequirePackage{graphicx}
\RequirePackage{multirow}
\RequirePackage{eurosym}
\RequirePackage[table]{xcolor}

% EdgeMind Colors
\definecolor{EMLogoBlue}        {cmyk}{0.96, 0.75, 0.30, 0.18}
\definecolor{EMLogoOrange}      {cmyk}{0.00, 0.61, 0.90, 0.00}
\definecolor{EMGrey}            {cmyk}{0.21, 0.17, 0.10, 0.00}
\definecolor{EMBrownLight}      {cmyk}{0.25, 0.47, 0.75, 0.15}
\definecolor{EMRed}             {cmyk}{0.21, 1.00, 0.92, 0.14}
\definecolor{EMBrown}           {cmyk}{0.34, 1.00, 0.91, 0.55}


\RequirePackage{fancyhdr}
\RequirePackage{lastpage} % Pour afficher le nombre de page
%\RequirePackage{helvet} % Pour une police qui ressemble à Arial
% Sans sérif
%\renewcommand\familydefault{\sfdefault}

\RequirePackage{titlesec}
\RequirePackage{blindtext}
\definecolor{gray75}{gray}{0.75}

%\newcommand{\hsp}{\hspace{20pt}}
%\titleformat{\chapter}[hang]{\Huge\bfseries}{\thechapter\hsp\textcolor{gray75}{|}\hsp}{0pt}{\Huge\bfseries}

\RequirePackage{setspace}
\onehalfspacing

% Mise en page
\RequirePackage{geometry}
\geometry{
%  nohead,
  top=2.25cm, 
  bottom=2.25cm, 
  left=2.5cm, 
  right=2.5cm}

% Redéfinition du style plain pour afficher les adresses uniquement sur la première page
\fancypagestyle{plain}{
  \fancyhead{} 
  \fancyfoot{}
  \fancyfoot[C]{{\fontsize{5}{5}\selectfont
    \textbf{EdgeMind - 23 rue du Départ, Boite 37, 75014 Paris} \\
    Société à Actions Simplifiée au capital de 10000\euro{} - R.C.S. Paris - SIRET : 799 582 945 00017 / APE : 7022Z
  }}
  \renewcommand{\headrulewidth}{0pt}
}

% Définition du pied de page classique dans le reste du document
\pagestyle{fancy}

\fancyhead{} % efface l'entête
\fancyfoot{} % efface le pied de page

% Suppression des filets
\fancyfoot[L]{\fontsize{7}{7}\selectfont\textsc{EdgeMind S.A.S.}}
\fancyfoot[C]{\fontsize{7}{7}\selectfont\textsc{Page \thepage/\pageref{LastPage}}}
\fancyfoot[R]{\fontsize{7}{7}\selectfont\textsc{\Vminutesref}}

%\lhead[]{\rightmark}
%\rhead[\bfseries\leftmark]{}%\bfseries\thepage}
%\chead{}

\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

%\renewcommand{\headrulewidth}{0.5pt} % Filet en haut de page
%\addtolength{\headheight}{0.5pt} % espace pour le filet

\renewcommand{\footrulewidth}{0pt} % pas de filet en bas

% \fancypagestyle{plain}
% { % pages de tetes de chapitre
%   \fancyhead{} % supprime l'entete
%   \renewcommand{\headrulewidth}{0pt} % et le filet
% }


% Mise en forme du texte
% Interligne
%\renewcommand\baselinestretch{1.1}
% Supprime l'indentation
\setlength{\parindent}{0pt}
% Espacement entre les paragraphes
%\setlength{\parskip}{1ex plus .4ex minus .4ex}
\setlength{\parskip}{2ex}

%\renewcommand{\chaptermark}[1]{\markboth{\thechapter.\ #1}{}}
%\renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}}


% User Commands
% =============

\newcommand*{\minutesref}[1]{\def\Vminutesref{#1}} \minutesref{REF}
%\newcommand*{\accessibilite}[1]{\def\Vaccess{#1}} \accessibilite{}
\newcommand*{\projectref}[1]{\def\Vprojectref{#1}} \projectref{}

\newcommand*{\place}[1]{\def\Vplace{#1}} \place{}
\newcommand*{\duration}[1]{\def\Vduration{#1}} \duration{}
\newcommand*{\meetingdate}[1]{\def\Vmeetingdate{#1}} \meetingdate{}

\newcommand*{\participants}[1]{\def\Vparticipants{#1}} \participants{}
\newcommand*{\excused}[1]{\def\Vexcused{#1}} \excused{}
\newcommand*{\recipients}[1]{\def\Vrecipients{#1}} \recipients{}


% Layout definition
% =================

\renewcommand{\maketitle}{ 
  {
    \thispagestyle{plain}

    \vspace{1cm}
    
    \begin{center}
      \includegraphics[width=3cm]{logo_edgemind_original}
    \end{center}
    % % Bidouillage infâme pour aligner le texte EDF R\&D et Département avec le filet grisé...
    % \hspace{-0.3cm}
    % \begin{tabularx}{\textwidth}{m{7.5cm}m{1.5cm}X} 
    %    %{{\fontsize{5}{5}\selectfont
    %     % Solution de bidouillage avec le \hspace et le \phantom pour que le texte apparaisse sur deux lignes.
    %     % Bidouillage encore avec le \hspace pour que le début apparaisse aligné avec le filet grisé situé en dessous.
    %     EdgeMind S.A.S.
    %   & \includegraphics[width=1.5cm]{logo_edgemind_original}
    %   &
    % \end{tabularx}
    %}  
  }

  \vspace{1cm}

  % Si on utilise \textwidth, ça dépasse un peu. Du coup, on est obligé de rectifier à la main
  \fcolorbox{black}{EMGrey}{\makebox[0.9875\textwidth][c]{\LARGE\textbf{\color{black}COMPTE RENDU DE R\'EUNION}}}
  
  \vspace{0.25cm}

   \begin{center}
     \begin{tabularx}{\textwidth}{|>{\raggedleft}m{4cm}X|}
       \hline
       &  \\[-.2cm]
       \textsc{Auteur} : & \@author             \\[.3cm] 
       \textsc{R\'ef\'erence} : & \Vminutesref  \\[.3cm]
       \textsc{Date} : & \@date                 \\[.3cm]
       \textsc{Projet} : & \Vprojectref         \\[.3cm]
       \textsc{Nombre de pages} : & \pageref{LastPage} \\[.3cm]
       \hline
       &  \\[-.2cm]
       \textsc{Objet :} & \@title         \\[.3cm]
       \textsc{Date :} & \Vmeetingdate          \\[.2cm]
       \textsc{Lieu :} & \Vplace          \\[.2cm]
       \textsc{Dur\'ee :} & \Vduration         \\[.2cm]
       \hline
       &  \\[-.2cm]
       \textsc{Participant(s) :} & \Vparticipants  \\[.3cm]
       \textsc{Excusé(s) :} & \Vexcused  \\[.3cm]
       \textsc{Destinataire(s) :} & \Vrecipients \\[.3cm]
       \hline
     \end{tabularx}
   \end{center}
}



% \renewcommand{\maketitle}
%   {
%     \thispagestyle{plain}

%     \begin{titlepage}
      
%       \vspace{1cm}

%       \hspace{-0.3cm}
%       \begin{tabularx}{\textwidth}{m{5cm}Xm{5cm}}
%         {\huge \textbf{EdgeMind}} \\
%         {\scriptsize \textit{Conseil et développement innovant}} \\
%         {\scriptsize \textit{pour la maîtrise des risques}}
%         & & 
%         \includegraphics[width=1.5cm]{logo_edf}
%       \end{tabularx}
  
%       Si on utilise \textwidth, ça dépasse un peu. Du coup, on est obligé de rectifier à la main
%       \fcolorbox{gray}{gray!25!white}{\makebox[0.9875\textwidth][c]{\LARGE\textbf{\@title}}}
      
%       \fcolorbox{gray}{gray!25!white}{\LARGE\textbf{\@title}}
      
%       \begin{center}

%         \vspace{0.1\textheight}

%         \begin{spacing}{2.0}
%           {\huge
%             \textbf{
%               \textsc{
%                 \@title
%               }
%             }
%           }
%         \end{spacing}
    
%         \vspace{0.1\textheight}

%         \Vresume
        
%         \vspace{0.1\textheight}
        
%         \begin{tabularx}{\textwidth}{|>{\raggedleft}m{6cm}X|}
%           \hline
%           & \\[-.5cm]
%           \textsc{Auteur} : & \@author          \\[.1cm]
%           \if\Vverif\@empty
%           \else
%           \textsc{Vérificateur} : & \Vverif \\[.1cm]
%           \fi
%           \hline
%           & \\[-.5cm]
%           \textsc{Date} : & \@date          \\[.1cm]
%           \textsc{Version} : & \Vversion          \\[.1cm]
%           \hline
%           & \\[-.5cm]
%           \textsc{Référence \Vclient} : & \Vrefclient        \\[.1cm]
%           \textsc{Référence EdgeMind} : & \Vrefedgemind        \\[.1cm]
%           \textsc{Date} : & \@date          \\[.1cm]
%           \hline
%         \end{tabularx}
%       \end{center}
      
%     \end{titlepage}
    
%   }
  