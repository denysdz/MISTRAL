class SelectWordModel {
  final int id;
  final String goodWord;
  final List<String> words;
  String selectedWord;

  SelectWordModel(
    this.id,
    this.goodWord,
    this.words, {
    this.selectedWord = "",
  });
}
