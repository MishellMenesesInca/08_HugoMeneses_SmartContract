// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title Billetera Digital con NatSpec
/// @notice Este contrato inteligente implementa una billetera digital básica en Ethereum.
/// @dev Permite a los usuarios depositar y retirar fondos y verificar su saldo.
contract BilleteraDigital {
    address public owner;  // Dirección del propietario de la billetera
    mapping(address => uint256) public saldo;  // Saldo de cada dirección

    /// @notice Constructor del contrato. El creador se convierte en el propietario.
    constructor() {
        owner = msg.sender;
    }

    /// @notice Permite a alguien depositar fondos en la billetera.
    /// @dev Solo el propietario puede depositar fondos.
    /// @param _destinatario La dirección a la que se enviarán los fondos.
    /// @param _cantidad La cantidad de ether a depositar.
    function depositar(address _destinatario, uint256 _cantidad) external payable {
        require(msg.sender == owner, "Solo el propietario puede depositar fondos");
        saldo[_destinatario] += _cantidad;
    }

    /// @notice Permite a alguien retirar fondos de la billetera.
    /// @param _cantidad La cantidad de ether a retirar.
    function retirar(uint256 _cantidad) external {
        require(saldo[msg.sender] >= _cantidad, "Saldo insuficiente");
        saldo[msg.sender] -= _cantidad;
        payable(msg.sender).transfer(_cantidad);
    }

    /// @notice Obtiene el saldo actual de la billetera de un usuario.
    /// @param _usuario La dirección del usuario.
    /// @return El saldo actual del usuario.
    function obtenerSaldo(address _usuario) external view returns (uint256) {
        return saldo[_usuario];
    }

    /// @notice Función de recepción de ether.
    /// Permite a la billetera recibir fondos directamente.
    receive() external payable {
        depositar(msg.sender, msg.value);
    }

    /// @notice Función Fallback.
    /// Permite a la billetera recibir fondos cuando se envían llamadas vacías.
    fallback() external payable {
        depositar(msg.sender, msg.value);
    }
}
