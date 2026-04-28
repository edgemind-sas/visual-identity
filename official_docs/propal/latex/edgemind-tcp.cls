\NeedsTeXFormat{LaTeX2e}
 
\ProvidesClass{edgemind-ptc}[2014/01/19, Edgemind technical and commercial proposal, V1.0]

% Class edgemind-tpc
%
% Latex class to write a technical and commercial proposal with the EdgeMind graphical identity.
%
% TODO :
% - Add an option to switch between French/English layout

% -----------------
% New user commands :

% Language
\def\langEN{EN}
\def\langFR{FR}
\def\langDE{DE}
\newcommand*{\thelang}[1]{\def\Vthelang{#1}} \thelang{\langEN}
% Customer name
\newcommand*{\customer}[1]{\def\Vcustomer{#1}} \customer{Apple}
% Customer project reference
\newcommand*{\refcustomer}[1]{\def\Vrefcustomer{#1}} \refcustomer{AAPL}
% EdgeMind project reference
\newcommand*{\refedgemind}[1]{\def\Vrefedgemind{#1}} \refedgemind{TCP-AAPLYYYYXXX}
% Version of the document
\newcommand*{\version}[1]{\def\Vversion{#1}} \version{1.0}
% To indicates if it is only a technical proposition
\newcommand*{\onlytechnical}[1]{\def\Vonlytechnical{#1}} \onlytechnical{false}
% -----------------

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
\RequirePackage{xcolor}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage} % To print the number of pages
\RequirePackage{setspace}

% EdgeMind Colors
\definecolor{EMLogoBlue}        {cmyk}{0.96, 0.75, 0.30, 0.18}
\definecolor{EMLogoOrange}      {cmyk}{0.00, 0.61, 0.90, 0.00}
\definecolor{EMGrey}            {cmyk}{0.21, 0.17, 0.10, 0.00}
\definecolor{EMBrownLight}      {cmyk}{0.25, 0.47, 0.75, 0.15}
\definecolor{EMRed}             {cmyk}{0.21, 1.00, 0.92, 0.14}
\definecolor{EMBrown}           {cmyk}{0.34, 1.00, 0.91, 0.55}


% Logo EdgeMind
\newcommand*{\EdgeMind}{{\textbf{\color{EMLogoBlue}Edge}}{\textnormal{\color{EMLogoOrange}Mind}}}

% Abstract
\newcommand*{\theabstract}[1]{\def\Vtheabstract{
\raggedright
{\textbf{
\ifx\Vthelang\langEN {Abstract} \fi
\ifx\Vthelang\langFR {R\'esum\'e} \fi
\ifx\Vthelang\langDE {Zusammenfassung} \fi
}} \\
\begin{spacing}{1.0}
#1
\end{spacing}
}} 

% Page layout
\RequirePackage{geometry}
\geometry{
  nohead,
  top=1.5cm, 
  bottom=2.25cm, 
  left=2cm, 
  right=1.5cm}

% Redefinition of style plain to print the adresses on the first page only
\fancypagestyle{plain}{
  \fancyhead{} 
  \fancyfoot{}
  \fancyfoot[C]{{\fontsize{5}{5}\selectfont
    \textbf{\EdgeMind{} - 23 rue du Départ, Boite 37, 75014 Paris} \\
    Société à Actions Simplifiée au capital de 10000\euro{} - R.C.S. Paris - SIRET : 799 582 945 00017 / APE : 7022Z
  }}
  \renewcommand{\headrulewidth}{0pt}
}

% Definition of the foot page for the rest of the document
\pagestyle{fancy}
\fancyhead{} % Clean the head page
\fancyfoot{} % Clean the foot page
\fancyfoot[L]{\fontsize{7}{7}\selectfont\textsc{\EdgeMind{} S.A.S.}}
\fancyfoot[C]{\fontsize{7}{7}\selectfont\textsc{Page \thepage/\pageref{LastPage}}}
\fancyfoot[R]{\fontsize{7}{7}\selectfont\textsc{Version \Vversion}}
% Remove the head/foot rules
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

% Text layout
\setlength\parindent{0cm}
\setlength\parskip{0.15cm}
\renewcommand\baselinestretch{1.1}

% Redefine the title command
\renewcommand{\maketitle}{ 
  {
    \thispagestyle{plain}

    \vspace{1cm}

    \begin{tabularx}{\textwidth}{m{5cm}Xm{5cm}} 
      \includegraphics[width=3cm]{logo_edgemind_original}
      & & 
    \end{tabularx}
  }
  
  \vspace{1cm}


  \begin{center}
    {\LARGE\textbf{\textsc{\@title}}}
    
    \vspace{3cm}
    
    {\Large \textbf{Proposition technique \ifthenelse{\equal{\Vonlytechnical}{false}}{et commerciale}{}}}

    \vspace{1cm}
    
    \begin{tabularx}{\textwidth}{|>{\raggedleft}m{6cm}X|}
       \hline
       & \\[-.2cm]
	\textsc{Customer:} : & \Vcustomer        \\[.1cm]
 	  \if\Vrefcustomer\@empty
          \else
           \textsc{Référence \Vcustomer} : & \Vrefcustomer        \\[.3cm]
          \fi
      
       \textsc{Référence \EdgeMind{}} : & \Vrefedgemind        \\[.3cm]

       \textsc{Date} : & \@date          \\[.3cm]
 	\textsc{Version} : & \Vversion          \\[.1cm]
          
       \hline
     \end{tabularx}
   \end{center}

    \vspace{0.1\textheight}
        
    \Vtheabstract
        
    \vspace{0.1\textheight}

   \clearpage
}
