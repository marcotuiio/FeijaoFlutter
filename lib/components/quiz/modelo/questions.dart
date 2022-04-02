class Question {
  final int id, answer;
  final String question;
  //final String comentario;
  final List<String> options;

  Question({
    required this.id,
    required this.question,
    required this.answer,
    required this.options,
    //required this.comentario,
  });
}

const List sampledata = [
  {
    "id": 90,
    "question": "Qual é o .... ?",
    "options": ['resposta 01', 'resposta 02', 'resposta 03', 'resposta 04'],
    "answer_index": 1, //index vai de 0 a 3
    "comentário": "dica 90"
  },
  {
    "id": 20,
    "question": "Qual é o questao 20.... ?",
    "options": ['resposta 01', 'resposta 02', 'resposta 03', 'resposta 04'],
    "answer_index": 2,
    "comentário": "dica 20"
  },
  {
    "id": 30,
    "question": "Qual é o ..questão 30.. ?",
    "options": ['resposta 01', 'resposta 02', 'resposta 03', 'resposta 04'],
    "answer_index": 2,
    "comentário": "dica 30"
  },
  {
    "id": 31,
    "question": "Qual é o ..questão 31.. ?",
    "options": ['resposta 01', 'resposta 02', 'resposta 03', 'resposta 04'],
    "answer_index": 3,
    "comentário": "dica 31"
  },
  {
    "id": 33,
    "question": "Qual é o ..questão 33.. ?",
    "options": ['resposta 01', 'resposta 02', 'resposta 03', 'resposta 04'],
    "answer_index": 2,
    "comentário": "dica 33"
  },
  {
    "id": 61,
    "question": "Qual é o ..questão 60.. ?",
    "options": ['resposta 01', 'resposta 02', 'resposta 03', 'resposta 04'],
    "answer_index": 3,
    "comentário": "dica 61"
  },
  {
    "id": 10,
    "question": "Qual é o .... ?",
    "options": ['resposta 01', 'resposta 02', 'resposta 03', 'resposta 04'],
    "answer_index": 0,
    "comentário": "dica 10"
  }
];
