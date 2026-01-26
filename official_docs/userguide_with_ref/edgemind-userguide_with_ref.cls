\NeedsTeXFormat{LaTeX2e}
 
\ProvidesClass{edgemind-userguide_with_ref}[2014/05/05, EdgeMind Userguide2 class, V1.0]
% Classe edgemind-report
%
% Latex class to write a user guide with the EdgeMind graphical identity.
%
% TODO :
% - Add an option to switch between French/English layout

% -----------------
% New user commands :

\def\langEN{EN}
\def\langFR{FR}
\def\langDE{DE}
\newcommand*{\thelang}[1]{\def\Vthelang{#1}}
% Customer name
\newcommand*{\customer}[1]{\def\Vcustomer{#1}} \customer{Apple}
% Customer project reference
\newcommand*{\refcustomer}[1]{\def\Vrefcustomer{#1}} \refcustomer{AAPL}
% EdgeMind project reference
\newcommand*{\refedgemind}[1]{\def\Vrefedgemind{#1}} \refedgemind{EM-RYYYYXXX}
% Version of the document
\newcommand*{\version}[1]{\def\Vversion{#1}} \version{1.0}

% subtitle
\newcommand*{\titlesub}[1]{\def\Vsubtitle{#1}} \titlesub{Subtitle}

% Controller
\newcommand*{\verif}[1]{\def\Vverif{#1}} \verif{}
% Abstract
\newcommand*{\theabstract}[1]{\def\Vtheabstract{
\raggedright
{\textbf{%
\ifx\Vthelang\langEN {Summary} \fi
\ifx\Vthelang\langFR {R\'esum\'e} \fi
\ifx\Vthelang\langDE {Zusammenfassung} \fi
}} \\
\begin{spacing}{1.0}
#1
\end{spacing}
}} 

\theabstract{My abstract : \\ Around 15 lines.}
\thelang{EN}
% -----------------


\LoadClass[a4paper, 11pt]{scrartcl}
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
\RequirePackage{lastpage}  % To print the number of pages

% EdgeMind Colors
\definecolor{EMLogoBlue}        {cmyk}{0.96, 0.75, 0.30, 0.18}
\definecolor{EMLogoOrange}      {cmyk}{0.00, 0.61, 0.90, 0.00}
\definecolor{EMGrey}            {cmyk}{0.21, 0.17, 0.10, 0.00}
\definecolor{EMBrownLight}      {cmyk}{0.25, 0.47, 0.75, 0.15}
\definecolor{EMRed}             {cmyk}{0.21, 1.00, 0.92, 0.14}
\definecolor{EMBrown}           {cmyk}{0.34, 1.00, 0.91, 0.55}


\RequirePackage[pdftex,pdfborder={0 0 0},bookmarks=true,bookmarksnumbered=true,pdfpagemode=None,pdfstartview=FitH,pdfpagelayout=SinglePage,colorlinks=true,linkcolor=EMLogoBlue,urlcolor=EMLogoBlue,citecolor=EMLogoBlue]{hyperref}

\RequirePackage{titlesec}
\RequirePackage{blindtext}
\definecolor{gray75}{gray}{0.75}
\newcommand{\hsp}{\hspace{20pt}}

\titleformat{\chapter}[hang]
{\color{EMLogoOrange}\Huge\bfseries}
{\thechapter\color{EMLogoOrange}\hsp{|}\hsp}{0pt}
{\color{EMLogoOrange}\Huge\bfseries}



\titleformat{\section}
{\color{EMLogoOrange}\normalfont\Large\bfseries}
{\color{EMLogoOrange}\thesection}{1em}{}

\RequirePackage{setspace}
\onehalfspacing

\RequirePackage[titles]{tocloft}

%\renewcommand\cftchapfont{\color{EMLogoBlue}}
\renewcommand\cftsecfont{\color{EMLogoBlue}}
\renewcommand\cftsubsecfont{\color{EMLogoBlue}}


%\renewcommand\cftchappagefont{\color{EMLogoOrange}}
\renewcommand\cftsecpagefont{\color{EMLogoOrange}}
\renewcommand\cftsubsecpagefont{\color{EMLogoOrange}}
\renewcommand\cftsubsubsecpagefont{\color{EMLogoOrange}}

% Page layout
\RequirePackage{geometry}
\geometry{
  top=2.25cm, 
  bottom=2.25cm, 
  left=2.5cm, 
  right=2.5cm}


% Definition of the foot page for the rest of the document
\pagestyle{fancy}
\fancyhead{} % Clean the head page
\fancyfoot{} % Clean the foot page
\fancyfoot[L]{\color{EMLogoBlue}\fontsize{7}{7}\selectfont\textsc{EdgeMind S.A.S.}}
\fancyfoot[C]{\color{EMLogoBlue}\fontsize{7}{7}\selectfont\textsc{Page \thepage/\pageref{LastPage}}}
\fancyfoot[R]{\color{EMLogoBlue}\fontsize{7}{7}\selectfont\textsc{Version \Vversion}}
\fancyhead[L]{\color{EMLogoOrange}\leftmark}
 \fancyhead[R]{\color{EMLogoOrange}\rightmark}
\chead{}

% Add section and chapter marks on head page

%\renewcommand{\chaptermark}[1]{\markboth{\thechapter.\ #1}{}}
\renewcommand{\subsectionmark}[1]{\markright{\thesubsection\ #1}}


% Remove the foot rule
\renewcommand{\footrulewidth}{0pt}
% Add an head rule
\renewcommand{\headrulewidth}{2pt} % thickness of the rule

\renewcommand{\headrule}{\hbox to\headwidth{%
  \color{EMLogoBlue}\leaders\hrule height \headrulewidth\hfill}}

\addtolength{\headheight}{0.5pt} % Space after the rule

% Chapter page
\fancypagestyle{plain}
{ 
  \fancyhead{} % remove head page
  \renewcommand{\headrulewidth}{1pt} % remove the rule

}


% Text layout
\setlength{\parindent}{0pt}
\setlength{\parskip}{2ex}


% Title page layout
% =================
\renewcommand{\maketitle}
  {
    \thispagestyle{plain}

    \begin{titlepage}
      
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

  	\vspace{0.05\textheight}

        \begin{spacing}{2.0}
        {
            	\color{EMLogoOrange}\huge\Vsubtitle 
        }
        \end{spacing}

        \vspace{0.1\textheight}

        \Vtheabstract
        
        \vspace{0.1\textheight}
        
        \begin{tabularx}{\textwidth}{|>{\raggedleft}m{6cm}X|}
          \hline
          & \\[-.5cm]
          \textsc{Author} : & \@author          \\[.1cm]
          \if\Vverif\@empty
          \else
          \textsc{Auditor} : & \Vverif \\[.1cm]
          \fi
          \hline
          & \\[-.5cm]
          \textsc{Date} : & \@date          \\[.1cm]
          \textsc{Version} : & \Vversion          \\[.1cm]
          \hline
          & \\[-.5cm]
          \textsc{\Vcustomer} REF. : & \Vrefcustomer        \\[.1cm]
          \textsc{EdgeMind} REF. : & \Vrefedgemind        \\[.1cm]
          \hline
        \end{tabularx}
      \end{center}
      
    \end{titlepage}
    
  }
  
