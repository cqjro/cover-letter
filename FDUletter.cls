%
% FDUletter.cls -- a document class for writing letters with OSU letterhead 
% This class based on "brownletter.cls" Copyright 2003, Nesime Tatbul (tatbul@cs.brown.edu)
%
% This version modifications by Huang Weiran 
% (huangweiran1998@outlook.com), 28 October 2019
% 
% New version modifications by Fanchao Chen
% (chenfanchao_robin@outlook.com), 23 October 2021
% Notes:
%
% 1. This class can be used for creating letters with FDU logo at the
%    header and  department address at the footer 
% 2. It is based on the standard Latex document class, letter.cls.
% 3. Required packages are epsfig and ifthen.
% 4. If FDU logo is to be included in the head, then the file
%    FDUlogo.eps must be provided. Otherwise, the logo is omitted.
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{FDUletter}
\RequirePackage{graphicx}
\RequirePackage{epstopdf}
\RequirePackage{epsfig}
\RequirePackage{ifthen}
\RequirePackage{xcolor}
\definecolor{slcolor}{HTML}{882B21}
%\RequirePackage{fontspec}
\DeclareGraphicsExtensions {.png} %{.pdf}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{letter}}
\ProcessOptions
\LoadClass[letterpaper]{letter} % we always use letter paper

\newcommand{\subjectname}{RE}
\newcommand{\@subject}{}
\newcommand{\subject}[1]{\renewcommand{\@subject}{\textbf{\subjectname: #1}}}

\newboolean{logofound}
\IfFileExists{fudan.png}
    {\setboolean{logofound}{true}}
    {\setboolean{logofound}{false}}

\setlength{\textwidth}{6.875in}
\setlength{\textheight}{8.5in}
\setlength{\topskip}{0.0in}
\setlength{\footskip}{1.0in}
\setlength{\oddsidemargin}{-0.25in}
\setlength{\evensidemargin}{-0.25in}
\setlength{\topmargin}{-0.875in}

\DeclareFixedFont{\xcmrbn}{OT1}{cmr}{b}{n}{10}
\DeclareFixedFont{\xcmrmn}{OT1}{cmr}{m}{n}{10}
\DeclareFixedFont{\ixcmrmn}{OT1}{cmr}{m}{n}{9}

\newsavebox{\departmenthead}
\newsavebox{\departmentfoot}
\newsavebox{\emptyfoot}

% \sbox{\departmenthead}{
%     \begin{tabular*}{\textwidth}
%                     {@{}c@{\extracolsep{0.0in}}@{\extracolsep{0.125in}}l@{}}           

% % HELP FOR SETTING UP PARBOXES
% % \parbox[position][height][inner-pos]{width}{text}
% % The \parbox has two mandatory arguments:
% %     width - specifies the width of the parbox, and
% %     text - the text that goes inside the parbox. 
% % LaTeX will position a parbox so its center lines up with the center of the text line. The optional position argument allows you to line up either the top or bottom line in the parbox (default is top).
% % If the height argument is not given, the box will have the natural height of the text.
% % The inner-pos argument controls the placement of the text inside the box. If it is not specified, position is used.
% %     t -- text is placed at the top of the box.
% %     c -- text is centred in the box.
% %     b -- text is placed at the bottom of the box.
% %LOGO
% %
%     \parbox{4.00in}
%     {
%         % \ifthenelse{\boolean{logofound}}
%         %    {\epsfig{file=logo.png, height=1.0in}}
%         %    {\parbox[c][1.0in][c]{4.0in}{} 
%         %     \ClassWarning{FDUletter}{fudan.png COULD NOT BE FOUND!}}
%     } &
% %DEPARTMENT OR SCHOOL
% %  This just sets the size of the box to the right of the logo, and the size of the vertical line.  The vertical line is set by the size of the first numerical argument of the \parbox command.
% %
% % In the future, the "From" address might be better set using "tikz".
% %     \parbox[c][1.8in][c]{2.225in}{{~}\\
% % }\\
%     \end{tabular*}
% }

\savebox{\emptyfoot}[\textwidth][c]{\ixcmrmn
    \hspace*{\textwidth}
}

% header and footer should be placed only on the first page
\renewcommand{\ps@firstpage}{
    \setlength{\headheight}{1.0in}
    \setlength{\headsep}{0.7in}
    \renewcommand{\@oddhead}{\usebox{\departmenthead}}
    \renewcommand{\@oddfoot}{}
    \renewcommand{\@evenhead}{}
    \renewcommand{\@evenfoot}{}
}

\renewcommand{\ps@empty}{
    \setlength{\headheight}{1.0in}
    \setlength{\headsep}{0.0in}
    \renewcommand{\@oddhead}{}
    \renewcommand{\@oddfoot}{}
    \renewcommand{\@evenhead}{}
    \renewcommand{\@evenfoot}{}
}

\providecommand{\@evenhead}{}
\providecommand{\@oddhead}{}
\providecommand{\@evenfoot}{}
\providecommand{\@oddfoot}{}

\pagestyle{empty}

% we add the subject command to the opening
\renewcommand{\opening}[1]{\thispagestyle{firstpage}%
    \ifx\@empty\fromaddress
        %{\raggedleft\@date\par}%
    \else  % home address
        {\raggedleft
            \begin{tabular}{l@{}}\ignorespaces
            \fromaddress \\ *[1\parskip]%
            %\@date
            \end{tabular}\par
        }%
     \fi
     \vspace{-11\parskip}
     \@date \vspace{2\parskip}\\
     {\raggedright \toname \\ \toaddress \par}%
     \vspace{1\parskip}%
     \ifthenelse{\equal{\@subject}{}}{}{\@subject\par}
     \vspace{1\parskip}%
     #1\par\nobreak
}

% we push closing to the right
\renewcommand{\closing}[1]{\par\nobreak\vspace{\parskip}%
    \stopbreaks
    \noindent
    \parbox{0.7\textwidth}{\raggedright
    \ignorespaces #1\\[3.5\medskipamount]%
    \ifx\@empty\fromsig
        \fromname
    \else \fromsig 
    \fi\strut}%
    \par
}

\setlength \labelsep {.5em} 
\newcommand\newblock{\hskip
  .11em\@plus.33em\@minus.07em} \let\@openbib@code\@empty
\newcommand\refname{References} 
\newcommand\section{\@startsection
  {section}{1}{\z@}%
  {-3.5ex \@plus -1ex \@minus -.2ex}%
  {2.3ex \@plus.2ex}%
  {\normalfont\Large\bfseries}} 
\newenvironment{thebibliography}[1]
{\section*{\refname}%
  \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}%
  \list{\@biblabel{\@arabic\c@enumiv}}%
  {\settowidth\labelwidth{\@biblabel{#1}}%
    \leftmargin\labelwidth \advance\leftmargin\labelsep \@openbib@code
    \usecounter{enumiv}%
    \let\p@enumiv\@empty \renewcommand\theenumiv{\@arabic\c@enumiv}}%
  \sloppy \clubpenalty4000 \@clubpenalty \clubpenalty
  \widowpenalty4000%
  \sfcode`\.\@m} {\def\@noitemerr {\@latex@warning{Empty
      `thebibliography' environment}}%
      \endlist}