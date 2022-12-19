# Desafio Stone
## Feito por Gabriel Ferreira de Carvalho
 
O Projeto iOS Stone é um aplicativo simples no qual é mostrado todos os personagens da série Rick E Morty filtrado por nome e ou status (vivo, morto ou desconhecido).
 
## Arquitetura
 
O Projeto segue uma arquitetura baseada no modelo MVI (Model - View - Interactor). 
 
### Model
A camada de modelo é responsável por definir os dados e como buscá-los, ou seja, são as structs que descrevem os personagens e episódios e as classes que são responsáveis por fazer as chamadas aos serviços remotos.
 
### View
A camada de View é dividida em 3 classes: View, ViewController e Presenter. A View é responsável por descrever o layout da tela através do uso de ViewCode e do framework UIKit. Já a ViewController é apenas usada para lidar com o ciclo de vida e para fazer o _bind_ entre o Presenter e os componentes da View. E por fim o Presenter é aquele que possui a referência do Interactor, ao observar o estado passado do Interactor, o Presenter o mapea em ViewModel que é simplesmente uma struct com os dados já organizados para disposição em tela. E quando o usuário realiza alguma ação como por exemplo apertar um botão, preencher um campo ou _scrollar_ até o final da lista o Presenter é responsável por mandar uma ação para o Interactor, o resultado da ação por fim gera um novo estado. A camada de View foi separada desta forma para permitir o maior desacoplamento possível da lógica de negócios com a ViewController. O fato de que a ViewController herda uma Classe de um Framework no caso o UIKit pode atrapalhar a testabilidade da parte dessa camada que conecta com a camada de lógica.
 
### Interactor
A camada de Interactor é responsável por receber uma ação e gerar um novo estado para aplicação a partir desta ação. O Interactor usa o _Design Pattern_ de Reducer ou seja, ele tem uma função que ao receber uma ação e o estado anterior ele retorna um _Observable_ com um novo estado, Isso torna essa camada muito simples de testar, pois a parte da classe que é responsável pela lógica de negócios é uma função pura que ao receber uma ação e um estado retorna um novo estado através de um _Observable_. O restante do Interactor é apenas _piping_ e abstração para permitir esse comportamento.
 
### Navegação
Para navegação foi utilizado um modelo de Coordinator unidirecional ou seja, o Coordinator não possui referência da ViewController apresentada, Esse _Design Pattern_ foi escolhido para permitir o desacoplamento da navegação do restante da camada de View, isso ajuda na testabilidade e permite um maior nível de abstração.
 
### Injenção de Depedencia
O Sistema de Injeção de dependência foi feito baseado na talk do [PointFree](https://www.pointfree.co) [How To Control The World - Stephen Celis](https://vimeo.com/291588126). O sistema funciona a partir de struct de _Environment_ onde é descrito todas as dependências do aplicativo a partir de variáveis com funções, no caso do desafio ele foi usado para descrever as funções para buscar os personagens, episódios e imagens de personagens. 
Essa forma permite o _override_ dessas funções de uma forma que facilita a testabilidade, concentra a dependências em um só lugar o que permite mudar o comportamento da aplicação inteira com apenas uma alteração de função. Ao mesmo tempo que isso permite aumentar a testabilidade da aplicação como o todo, também facilita que erros inesperados ocorram mais facilmente, já que é possível mudar o comportamento de uma função do _Environment_ a partir de qualquer lugar da aplicação. Logo é necessário ferramentas como SwiftLint e code reviews rígidas para coibir possíveis erros.
 
## Dependências
Foi usado o [CocoaPods](https://github.com/CocoaPods/CocoaPods) como ferramenta de gerenciamento de dependência. Ela é uma ferramenta amplamente usada pela comunidade de desenvolvimento iOS porém a principal razão da escolha desta ferramenta foi devido a um bug que o [Swift Package Manager](https://github.com/apple/swift-package-manager) tem com alguns pacotes como o [RxSwift](https://github.com/ReactiveX/RxSwift) quando eles são usados em dois targets diferentes como o target de Aplicação e Teste.
A única dependencia usada foi [RxSwift](https://github.com/ReactiveX/RxSwift), que é um framework de programação funcional reativa amplamente usada pela comunidade e permite descrever comportamento complexos com poucas linhas de código já que ele tem uma integração excelente com o UIKit.
 
## Dúvidas
Qualquer dúvida ou problema podem entrar em contato comigo, espero que gostem do projeto! =)


