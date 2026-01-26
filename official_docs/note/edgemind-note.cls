% -*- coding: utf-8 -*-

\NeedsTeXFormat{LaTeX2e}
 
\ProvidesClass{edgemind-note}[2014/07/16, EdgeMind Note class in english, V1.1]
% Classe edgemind-report
%
% Latex class to write a technical note with the EdgeMind graphical identity.
%
% V1.1 : Mimic Thomas's userguide style, merge edgemind-note-en in edgemind-note
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
\newcommand*{\refedgemind}[1]{\def\Vrefedgemind{#1}} \refedgemind{EM-RYYYYXXX}
% Version of the document
\newcommand*{\version}[1]{\def\Vversion{#1}} \version{1.0}
% Controller
\newcommand*{\verif}[1]{\def\Vverif{#1}} \verif{}
% subtitle
\newcommand*{\thesubtitle}[1]{\def\Vthesubtitle{#1}} \thesubtitle{Subtitle}

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

\theabstract{My abstract : \\ Around 15 lines.}
% -----------------


%\LoadClass[a4paper, 11pt]{scrartcl}
\LoadClass[a4paper, 11pt]{article}

\RequirePackage[default,scale=0.95]{opensans}
\renewcommand{\familydefault}{\sfdefault}
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
\RequirePackage{lastpage}  % To print the number of pages

% EdgeMind Colors
\definecolor{EMLogoBlue}        {cmyk}{0.96, 0.75, 0.30, 0.18}
\definecolor{EMLogoOrange}      {cmyk}{0.00, 0.61, 0.90, 0.00}
\definecolor{EMGrey}            {cmyk}{0.21, 0.17, 0.10, 0.00}
\definecolor{EMBrownLight}      {cmyk}{0.25, 0.47, 0.75, 0.15}
\definecolor{EMRed}             {cmyk}{0.21, 1.00, 0.92, 0.14}
\definecolor{EMBrown}           {cmyk}{0.34, 1.00, 0.91, 0.55}

\RequirePackage[pdfborder={0 0 0},bookmarks=true,bookmarksnumbered=true,pdfpagemode=None,pdfstartview=FitH,pdfpagelayout=SinglePage,colorlinks=true,linkcolor=EMBrown,urlcolor=EMBrown,citecolor=EMBrown]{hyperref}

\RequirePackage{titlesec}
\RequirePackage{blindtext}
\RequirePackage{setspace}
\onehalfspacing

\RequirePackage{sectsty}
\sectionfont{\color{EMLogoOrange}} 
\subsectionfont{\color{EMLogoBlue}}
\subsubsectionfont{\color{EMLogoBlue}}

% Page layout
\RequirePackage{geometry}
\geometry{
  top=2.25cm, 
  bottom=2.25cm, 
  left=2.5cm, 
  right=2.5cm}

% Redefinition of style plain to print the adresses on the first page only
\fancypagestyle{plain}{
  \fancyhead{} 
  \fancyfoot{}
  \fancyfoot[C]{{\fontsize{5}{5}\selectfont
    \textbf{\EdgeMind{} - 23 rue du D\'epart, Boite 37, 75014 Paris} \\[2pt]
    Soci\`et\'e \`a Actions Simplifi\'ee au capital de 10000\euro{} - R.C.S. Paris - SIRET : 799 582 945
    00017 / APE : 7022Z \\
  }}
  \renewcommand{\headrulewidth}{0pt}
}

% Definition of the foot page for the rest of the document
\pagestyle{fancy}
\fancyhead{} % Clean the head page
\fancyfoot{} % Clean the foot page
\fancyfoot[L]{\color{EMLogoBlue}\fontsize{7}{7}\selectfont\textsc{\EdgeMind{} S.A.S.}}
\fancyfoot[C]{\color{EMLogoBlue}\fontsize{7}{7}\selectfont\textsc{Page \thepage/\pageref{LastPage}}}
\fancyfoot[R]{\color{EMLogoBlue}\fontsize{7}{7}\selectfont\textsc{Version {\color{EMLogoOrange}\Vversion}}}
\fancyhead[L]{\raisebox{-.6\baselineskip}[0pt][0pt]{\color{EMLogoOrange}\leftmark}}
\fancyhead[R]{\raisebox{-.6\baselineskip}[0pt][0pt]{\color{EMLogoOrange}\rightmark}}
\chead{}

% \fancyfoot[L]{\fontsize{7}{7}\selectfont\textsc{EdgeMind S.A.S.}}
% \fancyfoot[C]{\fontsize{7}{7}\selectfont\textsc{Page \thepage/\pageref{LastPage}}}
% \fancyfoot[R]{\fontsize{7}{7}\selectfont\textsc{Version \Vversion}}

% Add section and chapter marks on head page

%\renewcommand{\chaptermark}[1]{\markboth{\thechapter.\ #1}{}}
\renewcommand{\subsectionmark}[1]{\markright{\thesubsection\ #1}}

% Remove the foot rule
\renewcommand{\footrulewidth}{0pt}
% Add an head rule
\renewcommand{\headrulewidth}{1pt} % thickness of the rule

\renewcommand{\headrule}{\hbox to\headwidth{%
  \color{EMLogoBlue}\leaders\hrule height \headrulewidth\hfill}}

\addtolength{\headheight}{0pt} % Space after the rule

% Chapter page
% \fancypagestyle{plain}
% { 
%   \fancyhead{} % remove head page
%   \renewcommand{\headrulewidth}{1pt} % remove the rule

% }


% Text layout
\setlength{\parindent}{0pt}
\setlength{\parskip}{1.5ex}


% Title page layout
% =================
\renewcommand{\maketitle}
  {

    \begin{titlepage}
      \thispagestyle{plain}
      
      \vspace{1cm}

      \hspace{-0.3cm}
      \begin{tabularx}{\textwidth}{m{5cm}Xm{5cm}}
        \includegraphics[width=3cm]{logo_edgemind_original}
        & & 
      \end{tabularx}
        
      \begin{center}

        \vspace{0.1\textheight}

        \begin{spacing}{2.0}
          {\Huge\color{EMLogoOrange}
            \textbf{
              \textsc{
                \@title
              }
            }
          }
        \end{spacing}
        
  	\vspace{0.025\textheight}
        
        \begin{spacing}{2.0}
          {
            \color{EMLogoOrange}\huge\Vthesubtitle 
          }
        \end{spacing}
        
        \vspace{0.1\textheight}
        
        \Vtheabstract
        
        \vspace{0.1\textheight}
        
        \begin{tabularx}{\textwidth}{|>{\raggedleft}m{0.45\textwidth}cX|}
          \hline
          & & \\[-.5cm]
          \ifx\Vthelang\langEN{\textsc{Author}}\fi
          \ifx\Vthelang\langFR{\textsc{Auteur}}\fi
          & : & \@author          \\[.1cm]
          \if\Vverif\@empty
          \else
          \ifx\Vthelang\langEN{\textsc{Auditor}}\fi
          \ifx\Vthelang\langFR{\textsc{V\'erificateur}}\fi
          & : & \Vverif \\[.1cm]
          \fi
          \hline
          & & \\[-.5cm]
          \textsc{Date} & : & \@date          \\[.1cm]
          \textsc{Version} & : & \Vversion          \\[.1cm]
          \hline
          & & \\[-.5cm]
          \textsc{\Vcustomer{} ref.} & : & \Vrefcustomer        \\[.1cm]
          \textsc{EdgeMind ref.} & : & \Vrefedgemind        \\[.1cm]
          \hline
        \end{tabularx}
      \end{center}
      
    \end{titlepage}
    
  }
  
