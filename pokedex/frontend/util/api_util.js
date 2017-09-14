const Util = {
  fetchAllPokemon: () => {
    return $.ajax({
      method: "GET",
      url: "/api/pokemon",
      type: "json"
    });
  }
};

export default Util;
