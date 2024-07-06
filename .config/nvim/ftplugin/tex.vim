vmap <c-m> di$<Esc>pa$

iabbrev == &=

nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

inoremap ;a \alpha
inoremap ;b \beta
inoremap ;d \delta
inoremap ;e \epsilon
inoremap ;g \gamma
inoremap ;t \theta
inoremap ;l \lambda
inoremap ;m \mu
inoremap ;p \pi
inoremap ;r \rho
inoremap ;s \sigma
inoremap ;S \Sigma
inoremap ;i \infty

inoremap ;SSS \subsection{<++>}<Esc>5h
inoremap ;SSE \section{<++>}<Enter>\label{sec:<++>}<++><Esc>1k0

inoremap ;BRB \bigg(<+bbr+>\bigg)<++><Esc>/<+bbr+><Enter>"_c7l
inoremap ;BSB \bigg[<+bsr+>\bigg]<++><Esc>/<+bsr+><Enter>"_c7l
inoremap \left( \left(\right)<++><Esc>10hi
inoremap \left[ \left[\right]<++><Esc>10hi

inoremap \{ \{\}<++><Esc>5hi
inoremap {} {}<++><Esc>4hi
inoremap () ()<++><Esc>4hi
inoremap [] []<++><Esc>4hi
inoremap $$ $$<++><Esc>4hi
" inoremap {} {<++>}<Esc>/<++><Enter>"_c4l
" inoremap {} {<++>}<++><Esc>/<++><Enter>"_c4l

inoremap ;/ \frac{}{<++>}<Esc><Esc>F{F{a
inoremap ;M \sum_{}^{<++>}<Esc><Esc>F{F{a
inoremap ;EFI \begin{figure}[<++>]<Enter>\centering<Enter>\includegraphics[scale=<++>]{./images/<++>}<Enter>\caption{<++>}<Enter>\label{fig:<++>}<Enter>\end{figure}<Esc>5k
inoremap ;EAL \begin{align}<Enter><++><Enter>\label{eq:<++>}<Enter>\end{align}<++><Esc>3k
inoremap ;EAN \begin{align*}<Enter><++><Enter>\end{align*}<++><Esc>2k
inoremap ;EQA \begin{equation}<Enter><++><Enter>\label{eq:<++>}<Enter>\end{equation}<++><Esc>3k
inoremap ;EQN \begin{equation*}<Enter><++><Enter>\end{equation*}<++><Esc>2k
inoremap ;PRG \begin{lstlisting}[language=Python]<Enter><++><Enter>\end{lstlisting}<++><Esc>3k
inoremap ;THE \begin{theorem}{<++>}<Enter><++><Enter>\end{theorem}<++><Esc>3k

inoremap ;MAT \begin{bmatrix}<Enter><++><Enter>\end{bmatrix}<Esc>2k
inoremap ;CAS \begin{cases}<Enter><++>&\text{<++>}\\<Enter><++>&\text{<++>}<Enter>\end{cases}<++><Esc>3k
inoremap ;EIT \begin{itemize}<Enter>\item<space><++><Enter>\end{itemize}<++><Esc>2k
inoremap ;EEN \begin{enumerate}<Enter>\item<space><++><Enter>\end{enumerate}<++><Esc>2k
inoremap ;ALG \begin{algorithm}[<++>]<Enter>\begin{algorithmic}[1]<Enter>\State Initialize<++><Enter>\If{<++>}<Enter>\State<Enter>\ElsIf{<++>}<Enter>\State <++><Enter>\Else<Enter>\State <++><Enter>\EndIf<Enter>\State <++><Enter>\end{algorithmic}<Enter>\caption{<++>}<Enter>\label{alg:<++>}<Enter>\end{algorithm*}
inoremap ;ENV \begin{<++>}<Enter>\end{<++>}<++><Esc>2k
inoremap ;EFR \begin{frame}{<++>}<Enter>\end{frame}<++><Esc>2k
inoremap ;ETA \begin{table}[<++>]<Enter>\setlength{\tabcolsep}{<++>pt}<Enter>\caption{<++>}<Enter>\label{table:<++>}<Enter>\centering<Enter>\begin{tabular}{<++>llc}<Enter>\toprule<Enter>\midrule<Enter>\cmidrule(r){1-2}<Enter>\bottomrule<Enter>\end{tabular}<Enter>\end{table}<++>
	
inoremap ;FBF \textbf{<++>}<Esc>/<++><Enter>"_c4l
inoremap ;FIT \textit{<++>}<Esc>/<++><Enter>"_c4l

inoremap ;MBF \mathbf{<++>}<Esc>/<++><Enter>"_c4l
inoremap ;MCA \mathcal{<++>}<Esc>/<++><Enter>"_c4l
inoremap ;MBB \mathbb{<++>}<Esc>/<++><Enter>"_c4l

function! s:PDFLATEX(...)
	silent execute printf('!pdflatex -synctex=1 -interaction=nonstopmode %s.tex', a:1)
	silent execute printf('!bibtex %s.aux', a:1)
	silent execute printf('!pdflatex -synctex=1 -interaction=nonstopmode %s.tex', a:1)
	silent execute printf('!bibtex %s.aux', a:1)
	execute printf('!pdflatex -synctex=1 -interaction=nonstopmode %s.tex', a:1)
	execute printf('!bibtex %s.aux', a:1)
endfunction
command! -nargs=1 PDF call s:PDFLATEX(<f-args>)

