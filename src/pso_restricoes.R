#DEFINIÇÃO DAS FUNCOES DE FITNESS E RESTRICOES 
calcular_fitness <- function(x) {
  penalidade_g <- sum(pmax(0, sin(2 * pi * x) + 0.5)^2)
  penalidade_h <- sum((cos(2 * pi * x) + 0.5)^2)
  fitness <- penalidade_g + penalidade_h
  return(fitness)
}

#INICIALIZACAO DOS PARAMETROS 
definir_parametros <- function() {
  list(
    num_particulas = 50,
    num_dimensoes = 5,
    max_iteracoes = 200,
    w = 0.5, #INERCIA
    c1 = 2.0, #INFLUENCIA COGNITIVO
    c2 = 2.0 #INFLUENCIA SOCIAL
  )
}

#FUNCAO PRINCIPAL
executar_pso <- function() {
  
  params <- definir_parametros()
  
  #INICIALIZACAO DAS PARTICULAS
  posicoes <- matrix(runif(params$num_particulas * params$num_dimensoes, -0.5, 0), 
                     nrow = params$num_particulas, ncol = params$num_dimensoes)
  velocidades <- matrix(runif(params$num_particulas * params$num_dimensoes, -0.05, 0.05), 
                        nrow = params$num_particulas, ncol = params$num_dimensoes)
  
  pbest <- posicoes
  fitness_pbest <- apply(pbest, 1, calcular_fitness)
  
  gbest <- pbest[which.min(fitness_pbest), ]
  fitness_gbest <- min(fitness_pbest)
  
  historico_fitness_medio <- numeric(params$max_iteracoes)
  historico_fitness_gbest <- numeric(params$max_iteracoes)
  historico_fitness_sd <- numeric(params$max_iteracoes)
  
  for (iteracao in 1:params$max_iteracoes) {
    for (i in 1:params$num_particulas) {
      velocidades[i, ] <- params$w * velocidades[i, ] +
        params$c1 * runif(params$num_dimensoes) * (pbest[i, ] - posicoes[i, ]) + #ATRAI A PARTICULA PARA A MELHOR POSICAO ANTERIOR
        params$c2 * runif(params$num_dimensoes) * (gbest - posicoes[i, ]) #ATRAI A PARTICULA PARA A MELHOR POSICAO GLOBAL
      
      posicoes[i, ] <- posicoes[i, ] + velocidades[i, ] #ATUALIZACAO DA POSICAO
      
      #RESTRINGE OS VALORES AO INTERVALO [-5.12, 5.12]
      posicoes[i, ] <- pmax(-5.12, pmin(5.12, posicoes[i, ]))
      
      
      #ATUALIZA PBEST
      fitness_atual <- calcular_fitness(posicoes[i, ])
      if (fitness_atual < fitness_pbest[i]) {
        pbest[i, ] <- posicoes[i, ]
        fitness_pbest[i] <- fitness_atual
      }
    }
    
    #ATUALIZA GBEST
    melhor_particula <- which.min(fitness_pbest)
    if (fitness_pbest[melhor_particula] < fitness_gbest) {
      gbest <- pbest[melhor_particula, ]
      fitness_gbest <- fitness_pbest[melhor_particula]
    }
    
    historico_fitness_medio[iteracao] <- mean(fitness_pbest)
    historico_fitness_gbest[iteracao] <- fitness_gbest
    historico_fitness_sd[iteracao] <- sd(fitness_pbest)
    
    cat("Iteração", iteracao, "- Melhor Fitness:", fitness_gbest, "\n")
  }
  
  list(gbest = gbest, fitness_gbest = fitness_gbest, 
       historico_fitness_medio = historico_fitness_medio, 
       historico_fitness_gbest = historico_fitness_gbest,
       historico_fitness_sd = historico_fitness_sd)
}

#EXIBE RESULTADOS
resultado <- executar_pso()
cat("Melhor indivíduo encontrado:", resultado$gbest, "\n")
cat("Fitness do melhor indivíduo:", resultado$fitness_gbest, "\n")

#===============================================================================================

#GERA OS GRAFICOS 
dir.create("../results", showWarnings = FALSE)

png("../results/graficos.png", width = 1200, height = 1400)

par(mfrow = c(3, 1))

plot(resultado$historico_fitness_gbest, type = "l", col = "red", lwd = 2,
     xlab = "Iterações", ylab = "Fitness do Melhor Indivíduo (GBest)",
     main = "Fitness do Melhor Indivíduo (GBest) ao Longo das Iterações")

plot(resultado$historico_fitness_medio, type = "l", col = "blue", lwd = 2,
     xlab = "Iterações", ylab = "Média da Fitness",
     main = "Média da Fitness ao Longo das Iterações")

plot(resultado$historico_fitness_sd, type = "l", col = "green", lwd = 2,
     xlab = "Iterações", ylab = "Desvio Padrão da Fitness",
     main = "Desvio Padrão da Fitness ao Longo das Iterações")

par(mfrow = c(1, 1))
dev.off()


