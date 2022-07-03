Configs = {};

// The number of question that will be presented to the player
Configs.nbQuestionToAnswer = 10

// Minimum number of good response needed for pass the test
Configs.neededPoint = 7

// List of questions, they will be retrieve randomly
Configs.questions = [
    {
        title: "Si vous roulez à 80 km/h et que vous approchez d'une zone résidentielle, vous devez:",
        image: "",
        responses: [
            { title: "Accélérez", type: false },
            { title: "Vous gardez votre vitesse, si vous ne dépassez pas d'autres véhicules", type: false },
            { title: "Vous ralentissez", type: true },
            { title: "Vous gardez votre vitesse", type: false }
        ]
    },
    {
        title: "Si vous tournez à droite à un feu rouge, mais que vous voyez un piéton traverser, que faites-vous:",
        image: "",
        responses: [
            { title: "Vous dépassez le piéton", type: false },
            { title: "Vous vérifiez qu'il n'y a pas d'autres véhicules autour", type: false },
            { title: "Vous attendez que le piéton ait traversé", type: true },
            { title: "Vous tirez sur le piéton et continuez à conduire", type: false }
        ]
    },
    {
        title: "Sans aucune indication préalable, la vitesse dans une zone résidentielle est de : __ km/h",
        image: "",
        responses: [
            { title: "30 km/h", type: false },
            { title: "50 km/h", type: true },
            { title: "40 km/h", type: false },
            { title: "60 km/h", type: false }
        ]
    },
    {
        title: "Avant chaque changement de voie, vous devez:",
        image: "",
        responses: [
            { title: "Vérifier vos rétroviseurs", type: false },
            { title: "Vérifier vos angles morts", type: false },
            { title: "Signaler vos intentions", type: false },
            { title: "Tout à la fois", type: true }
        ]
    },
    {
        title: "Quel taux d'alcoolémie correspond à la conduite en état d'ivresse ?",
        image: "",
        responses: [
            { title: "0.05%", type: false },
            { title: "0.18%", type: false },
            { title: "0.08%", type: true },
            { title: "0.06%", type: false }
        ]
    },
    {
        title: "Quand pouvez-vous continuer à conduire à un feu rouge ?",
        image: "",
        responses: [
            { title: "Quand il est vert", type: false },
            { title: "Quand il n'y a personne dans l'intersection", type: false },
            { title: "Vous êtes dans une zone scolaire", type: false },
            { title: "Lorsque le feu est vert et/ou rouge et que vous tournez à droite", type: true }
        ]
    },
    {
        title: "Un piéton a un signal d'interdiction de traverser, que faites-vous ?",
        image: "",
        responses: [
            { title: "Vous le laissez passer", type: false },
            { title: "Vous observez avant de continuer", type: false },
            { title: "Vous faites signe de la main pour leur dire de traverser", type: false },
            { title: "Vous continuez parce que votre feu est vert", type: true }
        ]
    },
    {
        title: "Qu'est-ce qui est autorisé quand on dépasse un autre véhicule",
        image: "",
        responses: [
            { title: "Vous le suivez de près pour le dépasser plus vite", type: false },
            { title: "Vous le dépassez sans quitter la chaussée", type: false },
            { title: "Vous conduisez sur le côté opposé de la route pour le dépasser", type: true },
            { title: "Vous dépassez la limite de vitesse pour le doubler", type: false }
        ]
    },
    {
        title: "Vous roulez sur une autoroute qui indique une vitesse maximale de 130 km/h. Mais la plupart des conducteurs roulent à 140 km/h, donc vous ne devriez pas rouler plus vite que:",
        image: "",
        responses: [
            { title: "110 km/h", type: false },
            { title: "120 km/h", type: false },
            { title: "130 km/h", type: true },
            { title: "140 km/h", type: false }
        ]
    },
    {
        title: "Lorsque vous êtes dépassé par un autre véhicule, il est important de NE PAS:",
        image: "",
        responses: [
            { title: "Ralentir", type: false },
            { title: "Vérifiez vos rétroviseurs", type: false },
            { title: "Regardez les autres conducteurs", type: false },
            { title: "Augmentez votre vitesse", type: true }
        ]
    }
]