abstract class BasePaginateResponse<T> {
  final List<T>? data;
  final int? number;
  final int? size;
  final int? totalElement;
  final int? totalPage;
  final bool? first;
  final bool? last;

  const BasePaginateResponse({
    this.number,
    this.size,
    this.totalElement,
    this.totalPage,
    this.first,
    this.last,
    this.data,
  });
}
