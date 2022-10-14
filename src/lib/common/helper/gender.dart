String gender(int genderId) {
  switch (genderId) {
    case 1:
      return 'Jantan';
    case 0:
      return 'Betina';
    default:
      return 'Tidak diketahui';
  }
}
