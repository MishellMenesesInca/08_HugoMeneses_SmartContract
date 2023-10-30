// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.13;

/// @title Billetera Digital - Un contrato inteligente para gestionar una billetera de ether.
/// @dev Este contrato permite depositar, enviar y consultar el saldo de ether en la billetera.
contract BilleteraDigital {
    // Dirección del propietario de la billetera.
    address public owner;

    /// @dev Constructor del contrato que establece al propietario inicial.
    /// @param _owner La dirección del propietario de la billetera.
    constructor(address _owner) {
        owner = _owner;
    }

    /// @notice Permite depositar ether en la billetera.
    /// @dev Esta función acepta ether y lo deposita en la billetera.
    function deposit() payable public {
        // No se requiere lógica adicional para el depósito.
    }  

    /// @notice Permite enviar ether a otra dirección.
    /// @dev Solo el propietario puede enviar ether a una dirección específica.
    /// @param to La dirección a la que se enviará el ether.
    /// @param amount La cantidad de ether a enviar.
    function send(address payable to, uint amount) public {
        if (msg.sender == owner) {
            to.transfer(amount);
            return;
        }
        revert("Esta cuenta no puede enviar dinero");
    }

    /// @notice Obtiene el saldo actual de la billetera.
    /// @dev Esta función consulta el saldo de ether en la billetera.
    /// @return El saldo actual de ether en la billetera.
    function balanceOf() view public returns(uint) {
        return address(this).balance;
    }
}
