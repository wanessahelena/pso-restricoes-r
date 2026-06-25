#  Otimização por enxame de partículas (Particle Swarm Optimization for Constrained Optimization - PSO)

Este repositório apresenta uma implementação do algoritmo de otimização por enxame de partículas (PSO) em R, aplicada a um problema de otimização com restrições representadas por funções de penalidade.

O projeto foi desenvolvido como trabalho da disciplina de Inteligência Artificial do curso de Engenharia de Computação do IFMG Bambuí.

---

## Objetivo

Implementar o algoritmo **PSO (Particle Swarm Optimization)** para minimizar uma função de fitness composta por penalizações associadas a restrições do problema.

A função objetivo utilizada é dada por:

[
fitness(x) = \sum \max(0, \sin(2\pi x) + 0.5)^2 + \sum (\cos(2\pi x) + 0.5)^2
]

onde:

* o primeiro termo representa uma penalização associada à restrição ( g(x) );
* o segundo termo representa uma penalização associada à restrição ( h(x) ).

---

## Descrição do problema

O algoritmo busca encontrar o melhor vetor (x) em um espaço de dimensão 5, respeitando os limites definidos para as partículas e minimizando a função de aptidão.

### Parâmetros utilizados

* Número de partículas: 50
* Número de dimensões: 5
* Número máximo de iterações: 200
* Peso de inércia (w): 0.5
* Coeficiente cognitivo (c1): 2.0
* Coeficiente social (c2): 2.0

---

## Estrutura do repositório

```bash
pso-restricoes-r/
│
├─ README.md
├─ .gitignore
├─ src/
│   └─ pso_restricoes.R
└─ results/
    └─ graficos.png
```

---

## Metodologia

O algoritmo segue as etapas clássicas do PSO:

1. Inicialização aleatória das partículas e velocidades;
2. Avaliação da função de aptidão para cada partícula;
3. Atualização do melhor individual (pbest);
4. Atualização do melhor global (gbest);
5. Atualização das velocidades com base em:

   * termo de inércia;
   * componente cognitiva;
   * componente social;
6. Atualização das posições das partículas;
7. Repetição do processo até o número máximo de iterações.

Durante a execução, o código também registra:

* o **melhor fitness global** por iteração;
* a **média do fitness** da população;
* o **desvio padrão do fitness** da população.

---

## Resultado

Ao final da execução, o script retorna:

* o melhor indivíduo encontrado;
* o valor do fitness do melhor indivíduo;
* gráficos com:

  * evolução do **GBest** ao longo das iterações;
  * evolução da **média da fitness**;
  * evolução do **desvio padrão da fitness**.

---

## Como Executar

1. Abra o R ou o RStudio;
2. Clone este repositório:

```bash
git clone https://github.com/wanessahelena/pso-restricoes-r.git
```

3. Abra o arquivo:

```r
src/pso_restricoes.R
```

4. Execute o script para rodar o algoritmo e gerar os gráficos.

---

## Resultado

Ao final da execução, o script retorna:

- o melhor indivíduo encontrado;
- o valor do fitness do melhor indivíduo;
- gráficos com:
  - evolução do **GBest** ao longo das iterações;
  - evolução da **média da fitness**;
  - evolução do **desvio padrão da fitness**.

### Armazenamento dos gráficos

Os gráficos gerados durante a execução são automaticamente salvos na pasta `results/` do projeto por meio da função `png()` do R.

Estrutura esperada:

```bash
results/
└── graficos.png

---

## Tecnologias

* **R**
* Funções básicas de visualização (`plot`)
* Implementação manual do algoritmo PSO

---

## Autoria

Projeto desenvolvido por **Wanessa Helena**.
