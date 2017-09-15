import React from "react";

class PokemonIndex extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    const pokemons = this.props.pokemon.map(poke => (
      <li>{poke.name} <br /><img src={poke.image_url} alt={poke.name} width="200"/></li>
    ));

    return (
      <div>
        <ul>
          { pokemons }
        </ul>
      </div>
    );
  }


  componentDidMount() {
    this.props.requestAllPokemon;
  }
}

export default PokemonIndex;
