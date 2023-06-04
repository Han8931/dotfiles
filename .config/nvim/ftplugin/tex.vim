nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')


vmap <c-m> di$<esc>pa$
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

inoremap ;SSE \subsection{<++>}<Esc>/<++><Enter>"_c4l
inoremap ;SSS \section{<++>}<Enter>\label{sec:<++>}<++>

inoremap ;BBR \bigg(<+bbr+>\bigg)<++><Esc>/<+bbr+><Enter>"_c7l
inoremap ;BSR \bigg[<+bsr+>\bigg]<++><Esc>/<+bsr+><Enter>"_c7l

inoremap {} {<++>}<++><Esc>/<++><Enter>"_c4l
inoremap [] [<++>]<++><Esc>/<++><Enter>"_c4l
" inoremap {} {<++>}<Esc>/<++><Enter>"_c4l

inoremap ;/ \frac{}{<++>}<Esc><Esc>F{F{a
inoremap ;M \sum_{}^{<++>}<Esc><Esc>F{F{a
inoremap ;EFI \begin{figure}[<++>]<Enter>\centering<Enter>\includegraphics[scale=<++>]{./images/<++>}<Enter>\caption{<++>}<Enter>\label{fig:<++>}<Enter>\end{figure}<Esc>F{F{a
inoremap ;EAL \begin{align}<Enter><+align+><Enter>\label{eq:<++>}<Enter>\end{align}<++><Esc>/<+align+><Enter>"_c9l
inoremap ;EAN \begin{align*}<Enter>\end{align*}<++><Esc>FnO

inoremap ;EIT \begin{itemize}<Enter>\item<space><+item+><Enter>\end{itemize}<++><Esc>/<+item+><Enter>"_c8l
inoremap ;EEN \begin{enumerate}<Enter>\item<space><+item+><Enter>\end{enumerate}<++><Esc>/<+item+><Enter>"_c8l
inoremap ;ALG \begin{algorithm}[<++>]<Enter>\begin{algorithmic}[1]<Enter>\State Initialize<++><Enter>\If{<++>}<Enter>\State<Enter>\ElsIf{<++>}<Enter>\State <++><Enter>\Else<Enter>\State <++><Enter>\EndIf<Enter>\State <++><Enter>\end{algorithmic}<Enter>\caption{<++>}<Enter>\label{alg:<++>}<Enter>\end{algorithm*}
inoremap ;EBI \begin{<++>}<Enter>\end{<++>}<++>
inoremap ;EFR \begin{frame}{<++>}<Enter>\end{frame}<++>
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

" inoremap ;bbr {<++>}<Esc>
" inoremap ;bsb {<++>}<Esc>

"inoremap <space><space> /<++><Enter>
"imap <space><space> /<++><Enter>

