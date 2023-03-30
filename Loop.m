(
    optional MaxPag as number,
    optional LoopsRealizados as number,
    optional TabelaAnterior as table
)=>

let
    // Cada vez que o algoritmo passar por aqui ele incrementa +1;
    Loop =
        if LoopsRealizados = null
        then 1
        else LoopsRealizados + 1,


    // Algoritmo irá tentar buscar os dados da página, caso ocorra um erro, irá carregar a variável com null;
    TabelaAtual=
        try NotasOobj (Loop)
        otherwise null,

    // A tabela abaixo será carregada "a cada passagem" que o algoritmo fizer por ela
    TabelaAnterior =
        if TabelaAnterior = null            // será null apenas na primeira passagem do algoritmo.
        then Table.FromRecords({[]})
        else TabelaAnterior,

    // Aqui vamos colar cada tabela encontrada, abaixo da outra
    TabelaFim = 
        if
                TabelaAtual = null
            or  Table.RowCount(TabelaAtual) = 0
        then TabelaAnterior
        else if Loop = 1
        then TabelaAtual
        else Table.Buffer( Table.Combine({TabelaAnterior, TabelaAtual}) ),

    // Condição para voltar ao início ou sair do Loop, finalizando-o
    out =
        if
                TabelaAtual = null
            or  Table.RowCount(TabelaAtual) = 0
            or  Loop = MaxPag
        then TabelaFim
        else @LoopingAPI(MaxPag, Loop, TabelaFim)

in
    out